class UsersController < ApplicationController

  before_action :require_admin, only: [:index, :new, :create]

  before_action only: [:show, :edit, :update] do
    require_self_sv_or_admin(User.find(params[:id]))
  end

  def index
    @title = "Users"
    @users = User.all
    @active_users = User.where(active: true).order(:lname, :fname)
    @inactive_users = User.where(active: false).order(:lname, :fname)
    @supervised_active_users = @active_users.where.not(supervisor_id: nil)

    @departments = Department.where(active: true)

    if current_user.admin?
      @timesheets_needing_review = Timesheet.where(hours_reviewed: nil).where.not(user_id: @user_auth_id_ary)
    end

    if current_user.has_authority_over.any?
      @user_auth = current_user.has_authority_over
      @user_auth_id_ary = @user_auth.pluck(:id)
      @timesheets_from_user_auth_needing_review = Timesheet.where(hours_reviewed: nil).where(user_id: @user_auth_id_ary)
    end

  end

  def show
    @title = "Staff"
    @user = User.find(params[:id])
    @user_staff = User.where(supervisor_id: @user.id)
    @users = User.all
    @active_users = @user_staff.where(active: true).order(:lname, :fname)
    @inactive_users = @user_staff.where(active: false).order(:lname, :fname)
    @supervised_active_users = @user_staff.where(active: true).order(:lname, :fname)
    @departments = Department.where(active: true)

    if current_user.has_authority_over.any?
      @user_auth = current_user.has_authority_over
      @user_auth_id_ary = @user_auth.pluck(:id)
      @timesheets_from_user_auth_needing_review = Timesheet.where(hours_reviewed: nil).where(user_id: @user_auth_id_ary)
    end
  end

  def new
    @title = "Add User"
    @user = User.new
    @active_def = true
    @salary_def = true
    @super_array = super_array
    @dept_array = dept_array
    @pw_lang = "Create password"
    session[:return_url] = back_uri

    @salary_hider = ""
    @hourly_hider = "hidden"

    @disabled = false
    @readonly_shower = "readonly-shower"
  end

  def edit
    @title = "Edit User"

    @user = User.find(params[:id])

    if current_user == @user
      @page_title = "Edit your profile"
    else
      @page_title = "Edit "+@user.fname+"\'s profile"
    end

    if current_user.can_approve_this?(@user)
      @disabled = false
      @readonly_shower = "readonly-shower"
    else
      @disabled = true
      @readonly_shower = ""
    end

    @active_def = @user.active
    @salary_def = @user.pay_type
    @super_array = super_array
    @dept_array = dept_array
    @pw_lang = "Change password"
    session[:return_url] = back_uri

    if @user.pay_type == "Salary"
      @salary_hider = ""
      @hourly_hider = "hidden"
    else
      @salary_hider = "hidden"
      @hourly_hider = ""
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "User created"
      redirect_to session[:return_url]
    else
      @dept_array = dept_array
      @super_array = super_array
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to session[:return_url]
    else
      @dept_array = dept_array
      @super_array = super_array
      render 'edit'
    end

  end

  def destroy
  end


  private

    def user_params
      params.require(:user).permit(
        :fname, :lname, :active, 
        :department_id, :supervisor_id, :time_zone,
        :email, :password, :password_confirmation, :admin, :time_zone, :start_date, :end_date,
        :annual_time_off, :standard_hours, :salary_rate, :hourly_rate, :pay_type)
    end

    # for _user_form select field
    def dept_array
      @dept_arry = Array.new([["(no department)", nil]])
      @dept_arry += Department.order(:name).to_a.map { |d| [d.name, d.id]}
      @dept_arry
    end

    # for _user_form select field
    def super_array
      @super_arry = Array.new([["(no supervisor)", nil]])
      sorted_arry = User.order(:fname, :lname).to_a
      sorted_arry.delete(@user)
      @super_arry += sorted_arry.map { |u| [u.fname+" "+u.lname, u.id]}
      @super_arry
    end
end
