class StaticPagesController < ApplicationController
  def home
    @title = "Home"
    @supervisor = false
    
    if current_user
      if User.where(active: true).where(supervisor_id: current_user.id).count > 0
        @supervisor = true
      end
    end

    @col = 12
    if current_user
      @col = 6 if current_user.admin? || @supervisor == true
      @col = 4 if current_user.admin? & @supervisor == true
    end
    

    @col_width = "col-xs-4 col-sm-2 col-md-2 col-lg-1"

    @col_class = "well col-xs-#{@col} col-md-#{@col}"
  end

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
