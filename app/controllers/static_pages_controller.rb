class StaticPagesController < ApplicationController
  def home
    @title = "Home"
    @supervisor = false
    @col_width = "col-xs-4 col-sm-2 col-md-2 col-lg-1"

    if current_user
      if User.where(active: true).where(supervisor_id: current_user.id).count > 0
        @supervisor = true
      end
      # Time off Request message calls
      @tors_need_approval = 0
      @direct_reports = User.where(supervisor_id: current_user.id)
      @direct_reports.each do |d|
        @tors_need_approval +=1 if d.requests.where(sv_approval: false).any?
      end #direct_reports loop

      @tors_denied = Request.where(user_id: current_user.id).where(sv_reviewed: true).where(sv_approval: false)
    end #current_user
  end #home

  def help
    @title = "Help"
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    @title = "Sign out"
    sign_out
    redirect_to root_path
  end
end
