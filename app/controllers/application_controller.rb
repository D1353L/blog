class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_return_url
    session[:return_to] = request.fullpath
  end
end
