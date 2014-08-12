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

    @year = params[:year] || Time.zone.now.year.to_s
    @pay_period = params[:pay_period] || Time.zone.now.strftime("%m/%d/%Y")
  end

  def supervisor
    @title = "Timeoff"
    @user = User.find(params[:user_id])
  end

  def admin
    @title = "Timeoff"
    @user = User.find(params[:user_id])
  end

  private

  def pay_period_start(m_d_y)
    common_date = m_d_y.split('/')
    m = common_date[0].to_i
    d = common_date[1].to_i
    y = common_date[2].to_i
    Date.new(y,m,d)
  end
end