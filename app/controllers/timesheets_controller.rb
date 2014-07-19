class TimesheetsController < ApplicationController

  def index
    @user = User.find(params[:user_id])

    @user_auth = @user.has_authority_over
    @user_auth_id_ary = @user_auth.pluck(:id)

    if params[:auth] == "over"
      @title = "Your Team's Timesheets"
      @timesheet_hours = TimesheetHour.where(user_id: @user_auth_id_ary).order(approved: :desc).order("created_at DESC").group(:timesheet_id).page(params[:page])
    else
      @title = "Your Timesheets"
      @timesheet_hours = TimesheetHour.where(user_id: @user.id).order("created_at DESC").group(:timesheet_id).page(params[:page])
    end

  end

  def show

  end

  def new
  end

  def edit
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.find(params[:id])
    @title = "Timesheet for #{@user.fname}"
  end

  def create
  end

  def update
  end

  private

end
