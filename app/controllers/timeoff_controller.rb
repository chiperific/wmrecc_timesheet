class TimeoffController < ApplicationController

  def single
    @title = "Timeoff"
    @user = User.find(params[:user_id])
    if current_user == @user
      @page_title = "Your Timeoff"
    else
      @page_title = "#{@user.fname}'s Timeoff"
    end
    @timeoff_hours = TimesheetHour.where(user_id: @user.id).where.not(timeoff_hours: 0).group(:timesheet_id).to_a
  end

  def supervisor
    @title = "Timeoff"
    @user = User.find(params[:user_id])
  end

  def admin
    @title = "Timeoff"
    @user = User.find(params[:user_id])
  end
end