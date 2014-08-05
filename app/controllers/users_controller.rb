class UsersController < ApplicationController

  before_action :require_admin, only: [:index, :new, :create]

  before_action only: [:show, :edit, :update] do
    require_supervisor(User.find(params[:id]))
  end

  def index
    @title = "Users"
    @users = User.all
    @active_users = User.where(active: true)
    @inactive_users = User.where(active: false)
    @supervised_active_users = @active_users.where("supervisor_id IS NOT NULL")

    @departments = Department.where(active: true)

    if current_user.admin?
      @timesheets_needing_review = TimesheetHour.where(reviewed: nil).where.not(user_id: @user_auth_id_ary).group(:timesheet_id).all
    end

    if current_user.has_authority_over.any?
      @user_auth = current_user.has_authority_over
      @user_auth_id_ary = @user_auth.pluck(:id)
      @timesheets_from_user_auth_needing_review = TimesheetHour.where(reviewed: nil).where(user_id: @user_auth_id_ary).group(:timesheet_id).all
    end

  end

  def show
    @title = "Staff"
    @user = User.find(params[:id])
    @user_staff = User.where(supervisor_id: @user.id)
    @users = User.all
    @active_users = @user_staff.where(active: true)
    @inactive_users = @user_staff.where(active: false)
    @supervised_active_users = User.where("supervisor_id IS NOT NULL")
    @departments = Department.where(active: true)

    if current_user.has_authority_over.any?
      @user_auth = current_user.has_authority_over
      @user_auth_id_ary = @user_auth.pluck(:id)
      @timesheets_from_user_auth_needing_review = TimesheetHour.where(reviewed: nil).where(user_id: @user_auth_id_ary).group(:timesheet_id).all
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
    session[:return_url] = URI(request.referrer).path
  end

  def edit
    @title = "Edit User"
    @user = User.find(params[:id])
    @active_def = @user.active
    @salary_def = @user.pay_type
    @super_array = super_array
    @dept_array = dept_array
    @pw_lang = "Change password"
    session[:return_url] = URI(request.referrer).path
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
        :department_id, :supervisor_id, 
        :email, :password, :password_confirmation, :admin, :annual_time_off, :standard_hours)
    end

    # for _user_form select field
    def dept_array
      @dept_arry = Array.new([["(no department)", nil]])
      @dept_arry += Department.all.sort_by { |d| d.name }.map { |d| [d.name, d.id]}
      @dept_arry
    end

    # for _user_form select field
    def super_array
      @super_arry = Array.new([["(no supervisor)", nil]])
      sorted_arry = User.all.sort_by { |u| u.fname }.sort_by { |u| u.lname}
      sorted_arry.delete(@user)
      @super_arry += sorted_arry.map { |u| [u.fname+" "+u.lname, u.id]}
      @super_arry
    end
end
