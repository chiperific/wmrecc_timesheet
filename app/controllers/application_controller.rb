class ApplicationController < ActionController::Base
  require 'action_view'
  include ActionView::Helpers::NumberHelper
  
  protect_from_forgery with: :exception
  include StaticPagesHelper

  before_action :require_login

  before_action :require_active_user, if: :current_user

  around_filter :user_time_zone, if: :current_user

  rescue_from 'ActiveRecord::RecordNotFound' do
    flash[:error] = "That doesn't seem to exist."
    redirect_to root_path
  end

#  rescue_from 'NoMethodError' do
#    flash[:error] = "That doesn't seem to exist."
#    redirect_to root_path
#  end

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

  def require_admin_or_unsupervised
    unless current_user.admin || current_user.supervisor_id == nil
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
    if !request.referer.nil?
      if request.fullpath == URI(request.referer).path
        back = root_path
      else
        back = request.referer
      end
    else
      back = root_path
    end
    URI(back).path
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

end
