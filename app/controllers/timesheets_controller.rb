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
    @user = User.find(params[:user_id])
    @user_id = @user.id
    @timesheet = Timesheet.new
    @url = user_timesheets_path(@user.id)

  end

  def edit
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.find(params[:id])
    @title = "Timesheet for #{@user.fname}"
    @url = user_timesheet_path(@user.id, @timesheet.id)

    
  end

  def create
  end

  def update
  end

  private

end
