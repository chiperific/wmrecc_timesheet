class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include StaticPagesHelper
  include UsersHelper

  before_filter :require_login

  private

   def require_login
    unless !current_user.nil?
      flash[:error] = "You need to login first."
      redirect_to root_path
    end
  end

  def require_admin
    unless current_user.admin
      flash[:error] = "You need to be an Administrator."
      redirect_to :back
    end
  end

  def require_supervisor(target)
    unless current_user.has_authority_over?(target)
      flash[:error] = "You don't supervise that user."
      redirect_to root_path
    end
  end

end
