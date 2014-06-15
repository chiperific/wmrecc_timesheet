class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
    
  end

  def destroy
    @title = "Sign out"
  end
end
