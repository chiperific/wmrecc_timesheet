class StaticPagesController < ApplicationController

  skip_before_action :require_login, only: [:home, :create, :destroy]
  
  def home
    @title = "Home"
    @col_width = "col-xs-4 col-sm-2 col-md-2 col-lg-1"
    @msg_col_width = "col-xs-6 col-sm-3"

    if current_user
      @denied_timesheets = TimesheetHour.where(user_id: current_user.id, approved: nil).where.not(reviewed: nil).group(:timesheet_id).all
      @denied_timeoffs = TimesheetHour.where(user_id: current_user.id, timeoff_approved: nil).where.not(timeoff_reviewed: nil).group(:timesheet_id).all

      if current_user.has_authority_over.any?
        @user_auth = current_user.has_authority_over
        @user_auth_id_ary = @user_auth.pluck(:id)
        @unapproved_timesheets = TimesheetHour.where(user_id: @user_auth_id_ary, approved: nil, reviewed: nil).group(:timesheet_id).all
        @unapproved_timeoffs = TimesheetHour.where(user_id: @user_auth_id_ary, timeoff_approved: nil, timeoff_reviewed: nil).group(:timesheet_id).all
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
  end

  def create
    user = User.find_by(email: params[:static_page][:email].downcase)
    if user && user.authenticate(params[:static_page][:password])
      sign_in user
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid email/password combination.'
      render root_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  def route_error
    flash[:error] = "That's not a real place."
    redirect_to root_path
  end
end
