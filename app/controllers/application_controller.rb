class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include StaticPagesHelper
  include UsersHelper

  before_action :require_login

  private

  # permission defs
    def save_previous_url
      session[:saved_previous_url] = URI(request.referrer).path
    end

   def require_login
    unless !current_user.nil?
      flash[:error] = "You need to login first."
      redirect_to root_path
    end
  end

  def require_admin
    unless current_user.admin
      flash[:error] = "You need to be an Administrator."
      redirect_to root_path
    end
  end

  def require_supervisor(user)
    unless current_user.has_authority_over?(user) || current_user == user || current_user.admin
      flash[:error] = "You don't supervise that user."
      redirect_to root_path
    end
  end

end
