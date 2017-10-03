class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /articles
  def index
    set_return_url
    @articles = Article.page(params[:page])
    flash.now[:error] = 'There are no any articles' if @articles.empty?
  end

  # GET /articles/1
  def show
    increment_views_count
    @random_articles = Article.where.not(id: @article.id).sample(3)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    redirect_to return_url || articles_url, notice: 'Article was successfully destroyed.'
  end

  private

    def increment_views_count
      return if session[:viewed] && session[:viewed].include?(@article.id)
      @article.increment!(:views_count)
      session[:viewed] = [] unless session[:viewed]
      session[:viewed] << @article.id
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :text, :image).merge({user: current_user})
    end
end
