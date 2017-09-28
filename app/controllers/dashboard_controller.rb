class DashboardController < ApplicationController

  def index
    set_return_url
    @articles = Article.page(params[:page])
  end
end
