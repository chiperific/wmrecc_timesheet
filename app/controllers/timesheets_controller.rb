class TimesheetsController < ApplicationController

  before_action do
    require_self_sv_or_admin(User.find(params[:user_id]))
  end

  def single
    @title = "Timesheet"
    @user = User.find(params[:user_id])
    if current_user == @user
      @page_title = "Your Timesheets"
    else
      @page_title = "#{@user.fname}'s Timesheets"
    end
    @timesheets = Timesheet.where(user_id: @user.id).order(:start_date)
  end

  def supervisor
    @title = "Timesheet"
    @user = User.find(params[:user_id])
    @page_title = "Your Team's Timesheets"

    
    @user_auth = @user.has_authority_over
    if !@user_auth.empty?
      @user_id_ary = @user_auth.pluck(:id)
    else
      @user_id_ary = []
    end

    @timesheets = Timesheet.where(hours_approved: nil, user_id: @user_id_ary).includes(:user).order('users.lname', 'users.fname').references(:users)

    @users_select = Hash.new
    @user_auth.each do |usr|
      @users_select[usr.full_name] = usr.id
    end
  end

  def admin
    @title = "Timesheet"
    @user = User.find(params[:user_id])
    @page_title = "All Timesheets"

    @timesheets = Timesheet.where(hours_approved: nil).includes(:user).order('users.lname', 'users.fname').references(:users)
    @user_id_ary = User.all.map { |u| u.id }
    @users_select = Hash.new
    User.where(active: true).order(:lname).each do |usr|
      @users_select[usr.full_name] = usr.id
    end
  end

  def archive
    @title = "Timesheet archive"
    @user = User.find(params[:user_id])
    @page_title = "All Timesheets"

    @timesheets = Timesheet.where.not(hours_approved: nil).includes(:user).order('users.lname', 'users.fname').references(:users)
    @user_id_ary = User.all.map { |u| u.id }

    @users_select = Hash.new
    if @user.admin
      User.where(active: true).order(:lname).each do |usr|
        @users_select[usr.full_name] = usr.id
      end
    else
      @user_auth.each do |usr|
        @users_select[usr.full_name] = usr.id
      end
    end
  end

  def new
    @title = "New Timesheet"
    @user = User.find(params[:user_id])

    @timesheet = Timesheet.new

    @hours_reviewed = ["Unreviewed", false]
    @hours_approved = ["Unapproved", false]
    @timeoff_hours_reviewed = ["Unreviewed", false]
    @timeoff_hours_approved = ["Unapproved", false]

    @timesheet_hours = weekday_ary

    @timesheet_categories = categories_ary

    session[:return_url] = back_uri

    @hours_ttl = 0.0
    @category_ttl = 0.0
    if @user.standard_hours == 0
      @standard_hours = 40
    else
      @standard_hours = @user.standard_hours.to_f
    end

    start_date = Date.commercial(Date.today.year, Date.today.cweek, 1)
    end_date = Date.commercial(Date.today.year, Date.today.cweek, 7)

    @human_start_date = start_date.strftime("%m/%d/%Y")
    @human_end_date = end_date.strftime("%m/%d/%Y")

    @ruby_start_date = start_date.strftime("%Y/%m/%d")
    @ruby_end_date = end_date.strftime("%Y/%m/%d")

    #for timesheet_finder timesheet_ary -- warns when overwritting an existing record
    @timesheets_json = Timesheet.where(user_id: @user.id).select('id, start_date, user_id').to_json

  end

  def edit
    @title = "Edit Timesheet"
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.find(params[:id])

    start_date = @timesheet.start_date
    end_date = @timesheet.end_date

    @human_start_date = start_date.strftime("%m/%d/%Y")
    @human_end_date = end_date.strftime("%m/%d/%Y")

    @ruby_start_date = start_date.strftime("%Y/%m/%d")
    @ruby_end_date = end_date.strftime("%Y/%m/%d")

    @hours_approved = @timesheet.hours_approved.present?
    @hours_reviewed = @timesheet.hours_reviewed.present?
    @timeoff_hours_reviewed = @timesheet.timeoff_reviewed.present?
    @timeoff_hours_approved = @timesheet.timeoff_approved.present?
    
    @timesheet_hours = weekday_ary

    @timesheet_categories = categories_ary

    @hours_ttl = @timesheet.timesheet_hours.sum(:hours).to_f
    @category_ttl = @timesheet.timesheet_categories.sum(:hours).to_f
    if @user.standard_hours == 0
      @standard_hours = 40
    else
      @standard_hours = @user.standard_hours.to_f
    end

    session[:return_url] = back_uri

    #for timesheet_finder timesheet_ary -- warns when overwritting an existing record
    @timesheets_json = Timesheet.where(user_id: @user.id).select('id, start_date, user_id').to_json
  end

  def create
    @user = User.find(params[:user_id])
    @start_date = Date.parse(params[:timesheet][:start_date])

    # If the timesheet already exists, update it
    @timesheet = Timesheet.find_or_initialize_by_start_date_and_user_id(@start_date, @user.id)

    if @timesheet.new_record?
      @timesheet.update_attributes(timesheet_params)
    else
      @timesheet.timesheet_hours.order(:day_num).each_with_index do |th, index|
        th.hours = params['timesheet']['timesheet_hours_attributes'][index.to_s]['hours']
        th.timeoff_hours = params['timesheet']['timesheet_hours_attributes'][index.to_s]['timeoff_hours']
        th.save
      end
      @timesheet.timesheet_categories.order(:category_id).each_with_index do |tc, index|
        tc.hours = params['timesheet']['timesheet_categories_attributes'][index.to_s]['hours']
        tc.save
      end
    end

    if @timesheet.save
      flash[:success] = "Timesheet submitted"
      redirect_to session[:return_url]
    else
      flash.now[:error] = "Failed to submit"
      render 'new'
    end
  end

  def update
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.find(params[:id])

    if @timesheet.update_attributes(timesheet_params)
      flash[:success] = "Timesheet updated"
      redirect_to session[:return_url]
    else
      flash.now[:error] = "Failed to update"
      render 'edit'
    end
  end

  private

    def timesheet_params
      params.require(:timesheet).permit(
        :start_date, :end_date, :user_id, :hours_approved, :hours_reviewed, :timeoff_approved, :timeoff_reviewed,
        :timesheet_hours_attributes =>      [:id, :timesheet_id, :day_num, :hours, :timeoff_hours],
        :timesheet_categories_attributes => [:id, :timesheet_id, :hours, :category_id]
      )
    end

    # for default select_tag values on _timesheet_approval_form
    def reviewed?
      if self.hours_reviewed.blank?
        ["Unreviewed", false]
      else
        ["Reviewed", true]
      end
    end

    def approved?
      if self.hours_approved.blank?
        ["Unapproved", false]
      else
        ["Approved", true]
      end
    end

    def timeoff_reviewed?
      if self.timeoff_reviewed.blank?
        ["Unreviewed", true]
      else
        ["Reviewed", true]
      end
    end

    def timeoff_approved?
      if self.timeoff_approved.blank?
        ["Unapproved", false]
      else
        ["Approved", true]
      end
    end

    def weekday_ary
      timesheet_hours = Array.new

      Weekday.all.order(:day_num).each do |wd|
        timesheet_hour = @timesheet.timesheet_hours.find_or_initialize_by(day_num: wd.day_num)
        timesheet_hours << timesheet_hour
      end
      timesheet_hours
    end

    def categories_ary
      timesheet_categories = Array.new

      Category.where(department_id: @user.department_id).each do |cat|
        timesheet_category = @timesheet.timesheet_categories.find_or_initialize_by(category_id: cat.id)
        timesheet_categories << timesheet_category
      end
      timesheet_categories
    end

  #end private
end
