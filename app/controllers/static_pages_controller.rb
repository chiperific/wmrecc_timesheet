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
        @unapproved_timesheets = TimesheetHour.where(user_id: @user_auth_id_ary, approved: nil, reviewed: nil).group(:timesheet_id).to_a
        @unapproved_timeoffs = TimesheetHour.where(user_id: @user_auth_id_ary, timeoff_approved: nil, timeoff_reviewed: nil).group(:timesheet_id).to_a
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

    @year = params[:year] || Time.now.in_time_zone.year
    @pay_period = params[:pay_period] || Time.now.in_time_zone.strftime("%m-%d")

    @departments = departments_lkup
  end

  def configure
    @title = "Configure"
    @app_default = AppDefault.first
    @weekdays = @app_default.weekdays.order( :day_num )

    @start_month = @app_default.start_months.first
    @months = Date::MONTHNAMES.dup.drop(1)

    @it_email = @app_default.it_emails.first || @app_default.it_emails.new

    @timeoff_accrual = @app_default.timeoff_accruals.first || @app_default.timeoff_accruals.new
    @accruals = ["Annual", "Weekly", "Bi-weekly"]

    @pay_period = @app_default.pay_periods.first || @app_default.pay_periods.new
    @periods = ["Bi-weekly", "Weekly", "Semi-monthly", "Monthly"]
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

    def app_default_params
      params.require(:app_default).permit( :name,
        :weekdays_attributes => [
          :id, :name, :abbr, :day_num, :app_default_id, :_destroy
        ],
        :start_months_attributes => [:id, :month],
        :it_emails_attributes => [:id, :email],
        :timeoff_accruals_attributes => [:id, :accrual_type],
        :pay_periods_attributes => [:id, :period_type]
      )
    end
end


