class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include StaticPagesHelper
  include UsersHelper
end
