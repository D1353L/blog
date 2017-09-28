class DashboardController < ApplicationController
  authorize_resource class: false

  def index
    set_return_url

    if current_user.has_role? :admin
      @articles = Article.page(params[:page])
      @copyriters = User.with_role(:copyriter).page(params[:page])
    elsif current_user.has_role? :copyriter
      @articles = Article.where(user: current_user).page(params[:page])
    end
  end
end
