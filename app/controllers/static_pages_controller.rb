class StaticPagesController < ApplicationController
  def home
    @title = "Home"
    @col_width = "col-xs-4 col-sm-2 col-md-2 col-lg-1"

    if current_user
      # FUTURE need to add unreviewed timeoff using has_authority_over
      if User.where(active: true).where(supervisor_id: current_user.id).count > 0
        @supervisor = true
      else
        @supervisor = false
      end
    end
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
