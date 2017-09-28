class DashboardController < ApplicationController
  authorize_resource class: false

  def index
    set_return_url
    @copyriters = User.accessible_by(current_ability).with_role(:copyriter).page(params[:page])

    if current_user.has_role? :admin
      @articles = Article.page(params[:page])
    elsif current_user.has_role? :copyriter
      @articles = Article.where(user: current_user).page(params[:page])
    end
  end
end
