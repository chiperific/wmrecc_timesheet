class StaticPagesController < ApplicationController

  skip_before_action :require_login, only: [:home, :create, :destroy]

  before_action :require_admin, only: [:configure]

  before_action :require_admin_or_unsupervised, only: [:payroll]

  def home
    @title = "Home"
    @col_width = "app-center col-xs-4 col-sm-2 col-md-2 col-lg-1"
    @msg_col_width = "col-xs-6 col-sm-3"

    if current_user
      @denied_timesheets = TimesheetHour.where(user_id: current_user.id, approved: nil).where.not(reviewed: nil).group(:timesheet_id).to_a
      @denied_timeoffs = TimesheetHour.where(user_id: current_user.id, timeoff_approved: nil).where.not(timeoff_reviewed: nil).group(:timesheet_id).to_a

      if current_user.has_authority_over.any?
        @user_auth = current_user.has_authority_over
        @user_auth_id_ary = @user_auth.pluck(:id)
        @unapproved_timesheets = TimesheetHour.where(user_id: @user_auth_id_ary, approved: nil, reviewed: nil).group(:timesheet_id, :user_id).to_a
        @unapproved_timeoffs = TimesheetHour.where(user_id: @user_auth_id_ary, timeoff_approved: nil, timeoff_reviewed: nil).group(:timesheet_id, :user_id).to_a
      end

      if @denied_timeoffs.any? || @denied_timesheets.any? || !@unapproved_timeoffs.nil? || !@unapproved_timesheets.nil?
        @message_board = true
      else
        @message_board = false
      end

    end #if current_user
  end

  def help
    @title = "Help"

    @admin_users = User.where(admin: true, active: true)

    @it_email = ItEmail.first
  end

  def create
    user = User.find_by(email: params[:static_page][:email].downcase)
    if user && user.authenticate(params[:static_page][:password])
      sign_in user
      redirect_to root_path
    else
      flash[:error] = 'Invalid email/password combination.'
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  def payroll
    @title = "Payroll"

    @pay_period_type = AppDefault.first.pay_periods.first.period_type
    @payroll_start = payroll_start
    @payroll_end = payroll_end

    @departments_lkup = departments_lkup

    @users = payroll_active_users
    @categories = payroll_active_cats

    @pay_period = params[:pay_period] || Time.now.in_time_zone.strftime("%m-%d")
    @year = params[:year] || Time.now.in_time_zone.year.to_s
  end

  def configure
    @title = "Configure"
    @pay_period_dialog_text = {
      "Weekly:" => "Process payroll weekly.",
      "Bi-weekly:" => "Process payroll at the end of even calendar weeks.",
      "Monthly:" => "Process payroll at the end of every month.",
      "Semi-monthly:" => "Process payroll every 6 months from Start of Year.",
      "Annually:" => "Process payroll at the end of every year from Start of Year"
    }
    @app_default = AppDefault.first
    @weekdays = @app_default.weekdays.order( :day_num )

    @start_month = @app_default.start_months.first
    @months = Date::MONTHNAMES.dup.drop(1)

    @it_email = @app_default.it_emails.first || @app_default.it_emails.new

    @timeoff_accrual = @app_default.timeoff_accruals.first || @app_default.timeoff_accruals.new
    @accruals = ["Annual", "Weekly", "Bi-weekly"]

    @pay_period = @app_default.pay_periods.first || @app_default.pay_periods.new
    @periods = ["Weekly","Bi-weekly","Monthly","Semi-monthly","Annually"]

    @holidays = @app_default.holidays

    @holiday_select_ary = []
    (1..12).each do |i|
      @holiday_select_ary << [ Date::ABBR_MONTHNAMES[i], i ]
    end

    @day_select_ary = []
    (0..6).each do |i|
      @day_select_ary << [ Date::ABBR_DAYNAMES[i], i ]
    end

    @week_select_ary = [["1st", 1], ["2nd", 2], ["3rd", 3], ["4th", 4], ["5th", 5]]
  end

  def configure_update
    #handle the nested attributes from app_default
    @app_default = AppDefault.first

    if @app_default.update_attributes(app_default_params)
      flash[:success] = "Configuration updated"
      redirect_to root_path
    else
      @title = "Error!"
      @months = Date::MONTHNAMES.dup.drop(1)
      @accruals = ["Annual", "Weekly", "Bi-weekly"]
      render 'configure'
    end
  end

  def route_error
    flash[:error] = "That's not a real place."
    redirect_to root_path
  end

  private

    # turn 'mm-dd' and 'yyyy' into a date
    def date_from_period_year(period, year)
      m_d = period.split('-')
      m = m_d[0].to_i
      d = m_d[1].to_i
      year = year.to_i
      date = Date.new(year,m,d)
    end

    def payroll_start
      pay_period_type = AppDefault.first.pay_periods.first.period_type
      year = params[:year] || Time.now.in_time_zone.year
      pay_period = params[:pay_period] || Time.now.in_time_zone.strftime("%m-%d")
      date = date_from_period_year(pay_period, year)

      if pay_period_type == "Weekly"
        start = date.beginning_of_week
      elsif pay_period_type == "Bi-weekly"
        if date.cweek.odd?
          start = date.beginning_of_week
        else
          start = (date.beginning_of_week - 1.week)
        end
      elsif pay_period_type == "Monthly"
        start = date.beginning_of_month
      else # Bi-monthly
        start_of_fy_name = AppDefault.first.start_months.first.month
        start_of_fy_num = Date::MONTHNAMES.index(start_of_fy_name)
        period_first = Date.new(year, start_of_fy_num, 1)
        period_second = (period_first + 6.months)
        if date >= period_first
          start = period_first
        else
          start = period_second
        end
      end
      start
    end

    def payroll_end
      pay_period_type = AppDefault.first.pay_periods.first.period_type
      year = params[:year] || Time.now.in_time_zone.year
      pay_period = params[:pay_period] || Time.now.in_time_zone.strftime("%m-%d")
      date = date_from_period_year(pay_period, year)

      if pay_period_type == "Weekly"
        ender = date.end_of_week
      elsif pay_period_type == "Bi-weekly"
        if date.cweek.even?
          ender = date.end_of_week
        else
          ender = (date.end_of_week + 1.week)
        end
      elsif pay_period_type == "Monthly"
        ender = date.end_of_month
      else # Bi-monthly
        start_of_fy_name = AppDefault.first.start_months.first.month
        start_of_fy_num = Date::MONTHNAMES.index(start_of_fy_name)
        period_first = Date.new(year, start_of_fy_num, 1)
        period_second = (period_first + 6.months)
        if date >= period_first
          ender = (period_second - 1.day)
        else
          ender = (period_first - 1.day)
        end
      end
      ender
    end

    # for payroll action
    def departments_lkup
      active_depts = Department.where(active: true)

      if active_depts.count > 1
        depts = ["All Depts"]
        active_depts.each do |d|
          depts << d.name
        end
      else
        depts = [active_depts.first.name]
      end
      depts
    end

    def payroll_active_users
      if !params[:dept].blank?
        dept = Department.where(active: true).where(name: params[:dept]).first
        usr = User.where(active: true).where(department_id: dept)
      else
        usr = User.where(active: true)
      end
      usr
    end

    def payroll_active_cats
      if !params[:dept].nil? && params[:dept] != "All Depts"
        dept_name = params[:dept]
        dept = Department.find_by_name(dept_name)
        cats = Category.where(active: true, department_id: dept.id)
      else
        cats = Category.where(active: true)
      end
      cats
    end

    def app_default_params
      params.require(:app_default).permit( :name,
        :weekdays_attributes => [
          :id, :name, :abbr, :day_num, :app_default_id, :_destroy
        ],
        :start_months_attributes => [:id, :month],
        :it_emails_attributes => [:id, :email],
        :timeoff_accruals_attributes => [:id, :accrual_type],
        :pay_periods_attributes => [:id, :period_type],
        :holidays_attributes => [
          :id, :name, :month, :day, :floating, :float_week, :float_day, :app_default_id, :_destroy
        ]
      )
    end
end


