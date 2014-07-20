class TimesheetsController < ApplicationController

  def index
    @user = User.find(params[:user_id])

    if params[:auth] == "over"
      @user_auth = @user.has_authority_over
      @user_auth_id_ary = @user_auth.pluck(:id)
      @title = "Your Team's Timesheets"
      @timesheet_hours = TimesheetHour.where(user_id: @user_auth_id_ary).order(approved: :desc).order(created_at: :desc).group(:timesheet_id).page(params[:page])
    else
      @title = "Your Timesheets"
      @timesheet_hours = TimesheetHour.where(user_id: @user.id).order(created_at: :desc).group(:timesheet_id).page(params[:page])
    end

  end

  def show

  end

  def new
    @title = "New Timesheet"
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.new
    @url = user_timesheets_path(@user.id)

    @timesheet_hours = Array.new

    7.times do |day_num|
      timesheet_hour = @timesheet.timesheet_hours.build(user_id: @user.id, weekday: day_num+1)
      @timesheet_hours << timesheet_hour
    end

    @timesheet_categories = Array.new

    Category.where(department_id: @user.department_id).each do |cat|
      timesheet_category = @timesheet.timesheet_categories.build(user_id: @user.id, category_id: cat.id)
      @timesheet_categories << timesheet_category
    end

  end

  def edit
    @title = "Edit Timesheet"
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.find(params[:id])
    @title = "Timesheet for #{@user.fname}"
    @url = user_timesheet_path(@user.id, @timesheet.id)

    @timesheet_hours = Array.new

    7.times do |day_num|
      timesheet_hour = @timesheet.timesheet_hours.find_or_initialize_by(user_id: @user.id, weekday: day_num+1)
      @timesheet_hours << timesheet_hour
    end

    @timesheet_categories = Array.new

    Category.where(department_id: @user.department_id).each do |cat|
      timesheet_category = @timesheet.timesheet_categories.find_or_initialize_by(user_id: @user.id, category_id: cat.id)
      @timesheet_categories << timesheet_category
    end

  end

  def create
  end

  def update
  end

  private

end
