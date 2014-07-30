class TimesheetsController < ApplicationController

  def index
    @title = "Timesheet"
    @user = User.find(params[:user_id])

    if params[:auth] == "over"
      @page_title = "Your Team's Timesheets"

      @user_auth = @user.has_authority_over
      @user_auth_id_ary = @user_auth.pluck(:id)
      @timesheets_for_user_auth = TimesheetHour.where(user_id: @user_auth_id_ary).joins(:timesheet).order('timesheets.year DESC', 'timesheets.week_num DESC').group(:timesheet_id).page(params[:page])

      if current_user.admin?
        #@timesheets_for_other_users = TimesheetHour.where.not(user_id: @user_auth_id_ary).group(:timesheet_id)
        @timesheets_needing_review = TimesheetHour.where(reviewed: nil).where.not(user_id: @user_auth_id_ary).group(:timesheet_id).all
      end

      if current_user.has_authority_over.any?
        @user_auth = current_user.has_authority_over
        @user_auth_id_ary = @user_auth.pluck(:id)
        @timesheets_from_user_auth_needing_review = TimesheetHour.where(reviewed: nil).where(user_id: @user_auth_id_ary).group(:timesheet_id).all
      end

      @direct_reports_select = Hash.new
      @user_auth.each do |usr|
        @direct_reports_select[usr.full_name] = usr.id
      end
    else
      @page_title = "Your Timesheets"
      @timesheet_hours = TimesheetHour.where(user_id: @user.id).joins(:timesheet).order('timesheets.year DESC', 'timesheets.week_num DESC').group(:timesheet_id).page(params[:page])
    end # if params[:auth] == 'over'

    if params[:auth] == "admin"
      @page_title = "All Unreviewed Timesheets"
    end

  end

  def show

  end

  def timeoff

  end

  def new
    @title = "New Timesheet"
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.new
    @timesheet_date = Date.today

    @url = user_timesheets_path(@user.id)

    @timesheet_hours = Array.new

    Weekday.all.each do |wd|
      timesheet_hour = @timesheet.timesheet_hours.find_or_initialize_by(user_id: @user.id, weekday: wd.id)
      @timesheet_hours << timesheet_hour
    end

    @timesheet_categories = Array.new

    Category.where(department_id: @user.department_id).each do |cat|
      timesheet_category = @timesheet.timesheet_categories.find_or_initialize_by(user_id: @user.id, category_id: cat.id)
      @timesheet_categories << timesheet_category
    end

  end

  def edit
    @title = "Edit Timesheet"
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.find(params[:id])
    @timesheet_date = Date.parse @timesheet.week_num_to_date_obj
    
    @url = user_timesheet_path(@user.id, @timesheet.id)

    @timesheet_hours = Array.new

    Weekday.all.each do |wd|
      timesheet_hour = @timesheet.timesheet_hours.find_or_initialize_by(user_id: @user.id, weekday: wd.id)
      @timesheet_hours << timesheet_hour
    end


    @timesheet_categories = Array.new

    Category.where(department_id: @user.department_id).each do |cat|
      timesheet_category = @timesheet.timesheet_categories.find_or_initialize_by(user_id: @user.id, category_id: cat.id)
      @timesheet_categories << timesheet_category
    end

  end

  def create
    @user = User.find(params[:user_id])
    @timesheet_date = Date.today

    # If the timesheet already exists, update it
    if Timesheet.where( week_num: params[:timesheet][:week_num], year: params[:timesheet][:year]).exists?

      @timesheet_ary = Timesheet.where( week_num: params[:timesheet][:week_num], year: params[:timesheet][:year])
      @timesheet = @timesheet_ary.first

      if @timesheet.update_attributes(timesheet_params)
        flash[:success] = "Timesheet updated"
        redirect_to user_timesheets_path(@user)
      else
        flash[:error] = "It broke"
        render 'new'
      end

    else

      @timesheet = Timesheet.new(timesheet_params)
      if @timesheet.save
        flash[:success] = "Timesheet submitted"
        redirect_to user_timesheets_path(@user)
      else
        flash[:error] = "It broke"
        render 'new'
      end

    end

  end

  def update
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.find(params[:id])

    if @timesheet.update_attributes(timesheet_params)
      flash[:success] = "Timesheet updated"
      if current_user != @user
        if current_user.has_authority_over?(@user)
          redirect_to user_timesheets_path(current_user, auth: "over")
        elsif current_user.admin
          redirect_to user_timesheets_path(current_user, auth: "admin")
        end
      else
        redirect_to user_timesheets_path(@user)
      end
    else
      flash[:error] = "It broke"
      render 'edit'
    end

  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:week_num, :year,
      :timesheet_hours_attributes =>      [:id, :timesheet_id, :user_id, :weekday, :hours, :reviewed, :approved, :timeoff_hours, :timeoff_reviewed, :timeoff_approved],
      :timesheet_categories_attributes => [:id, :timesheet_id, :user_id, :hours, :category_id]
    )
  end

  # for defaul select_tag values on _timesheet_approval_form
  def reviewed?
    if self.reviewed.blank?
      ["Unreviewed", true]
    else
      ["Reviewed", true]
    end
  end

  def approved?
    if self.approved.blank?
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

end
