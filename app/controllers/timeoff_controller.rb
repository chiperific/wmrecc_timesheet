class TimeoffController < ApplicationController

  def single
    @user = User.find(params[:user_id])
    if current_user == @user
      @page_title = "Your Timeoff"
    else
      @page_title = "#{@user.fname}'s Timeoff"
    end
    @timeoff_hours = TimesheetHour.where(user_id: @user.id).where.not(timeoff_hours: 0).group(:timesheet_id).all
  end

  def supervisor
    @user = User.find(params[:user_id])
  end

  def admin
    @user = User.find(params[:user_id])
  end
end