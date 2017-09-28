module ApplicationHelper
  def return_url
    session[:return_to]
  end
end
