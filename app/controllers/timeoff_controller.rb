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
    @timeoff_hours = Timesheet.where(user_id: @user.id).includes(:timesheet_hours).where("timesheet_hours.timeoff_hours > 0").references(:timesheet_hours)

    @user_start_year = if @user.start_date.nil? then @user.created_at.year else @user.start_date.year end

    @timeoff_accrual_type = TimeoffAccrual.first.accrual_type
    if !params[:date]
      @date = Date.today.start_of_period
    else
      @date = params[:date].to_date
    end
    @visible_date = @date.strftime("%m/%d/%y")
  end

  def supervisor
    @title = "Timeoff"
    @user = User.find(params[:user_id])

    @timeoff_hours = Timesheet.where(user_id: @user.has_authority_over).includes(:timesheet_hours).where("timesheet_hours.timeoff_hours > 0").references(:timesheet_hours)
  end

  def admin
    @title = "Timeoff"

    @timeoff_hours = Timesheet.includes(:timesheet_hours).where("timesheet_hours.timeoff_hours > 0").references(:timesheet_hours)
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