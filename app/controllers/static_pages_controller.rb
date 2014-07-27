class StaticPagesController < ApplicationController
  def home
    @title = "Home"
    @col_width = "col-xs-4 col-sm-2 col-md-2 col-lg-1"

    if current_user
      if User.where(active: true).where(supervisor_id: current_user.id).count > 0
        @supervisor = true
      else
        @supervisor = false
      end

      @denied_timesheet_hours = TimesheetHour.where(user_id: current_user.id, timeoff_approved: nil).where.not(timeoff_reviewed: nil)

      if @denied_timesheet_hours.any?
        flash.now[:error] = 'You have ' + @denied_timesheet_hours.count.to_s + ' denied timeoff ' + 'request'.pluralize(@denied_timesheet_hours.count) + '.'
      end


      if current_user.has_authority_over.any?
        @user_auth = current_user.has_authority_over
        @user_auth_id_ary = @user_auth.pluck(:id)
        @unapproved_timesheet_hours = TimesheetHour.where(user_id: @user_auth_id_ary, timeoff_approved: nil, timeoff_reviewed: nil).group(:timesheet_id).all

        if @unapproved_timesheet_hours.any?
          flash.now[:success] = 'You have ' + @unapproved_timesheet_hours.count.to_s + ' timeoff ' + 'request'.pluralize(@unapproved_timesheet_hours.count) + ' to review.'
        end
      end

    end #if current_user
  end

  def help
    @title = "Help"
  end

  def create
    user = User.find_by(email: params[:static_page][:email].downcase)
    if user && user.authenticate(params[:static_page][:password])
      sign_in user
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render root_path
    end
  end

  def destroy
    @title = "Sign out"
    sign_out
    redirect_to root_path
  end
end
