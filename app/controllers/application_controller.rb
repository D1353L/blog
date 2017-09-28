class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  check_authorization unless: :devise_controller?

  def set_return_url
    session[:return_to] = request.fullpath
  end
end
