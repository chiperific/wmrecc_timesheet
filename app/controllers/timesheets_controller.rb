class TimesheetsController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    #@user_timesheet_hours = TimesheetHour.where(user_id: @user.id)
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
