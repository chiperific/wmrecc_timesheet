class TimesheetsController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    @timesheets = TimesheetHour.where(user_id: @user.id).order("created_at DESC").group(:timesheet_id).page(params[:page])

    if current_user == @user
      @user_or_self = "Your Timesheets"
    else
      @user_or_self = "Timesheets for #{@user.fname}"
    end

  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end
end
