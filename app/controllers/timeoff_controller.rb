class TimeoffController < ApplicationController

  before_action do
    require_self_sv_or_admin(User.find(params[:user_id]))
  end

  def single
    @title = "Timeoff"
    @user = User.find(params[:user_id])
    if current_user == @user
      @page_title = "Your Timeoff"
    else
      @page_title = "#{@user.fname}'s Timeoff"
    end
    @timeoff_hours = TimesheetHour.where(user_id: @user.id).where.not(timeoff_hours: 0).group_by(&:timesheet_id).to_a

    @user_start_year = if @user.start_date.nil? then @user.created_at.year else @user.start_date.year end 
    @year = params[:year] || Time.now.in_time_zone.year
    @pay_period = params[:pay_period] || Time.now.in_time_zone.strftime("%m-%d")

    @timeoff_accrual_type = TimeoffAccrual.first.accrual_type

  end

  def supervisor
    @title = "Timeoff"
    @user = User.find(params[:user_id])

    @timeoff_hours = TimesheetHour.where(user_id: @user.has_authority_over).where.not(timeoff_hours: 0).group(['timesheet_id','user_id']).to_a
  end

  def admin
    @title = "Timeoff"

    @timeoff_hours = TimesheetHour.where.not(timeoff_hours: 0).group(['timesheet_id','user_id']).to_a
  end

  private

  def pay_period_start(m_d_y)
    common_date = m_d_y.split('/')
    m = common_date[0].to_i
    d = common_date[1].to_i
    y = common_date[2].to_i
    start = Date.new(y,m,d)
  end
end