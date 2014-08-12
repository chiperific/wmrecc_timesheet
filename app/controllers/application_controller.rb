class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include StaticPagesHelper
  include UsersHelper

  before_action :require_login

  before_action :require_active_user

  around_filter :user_time_zone, if: :current_user

  rescue_from 'ActiveRecord::RecordNotFound' do
    flash[:error] = "That doesn't seem to exist."
    redirect_to root_path
  end

  private

  # permission defs
  def deny_all
    flash[:error] = "There's nothing there."
    redirect_to root_path
  end

  def require_login
    unless !current_user.nil?
      flash[:error] = "You need to login first."
      redirect_to root_path
    end
  end

  def require_active_user
    unless current_user.active?
      flash[:error] = "You aren't an active user."
      redirect_to root_path
    end
  end

  def require_admin
    unless current_user.admin
      flash[:error] = "You need to be an Administrator."
      redirect_to root_path
    end
  end

  def require_self_sv_or_admin(user)
    unless current_user.has_authority_over?(user) || current_user == user || current_user.admin
      flash[:error] = "You don't supervise that user."
      redirect_to root_path
    end
  end

  def back_uri
    path = request.referer || root_path
    URI(path).path
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  

end
