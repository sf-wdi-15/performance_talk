class ArticlesController < ApplicationController
  before_action :logged_in?
  before_action :set_user_article, only: [:edit, :update, :destroy]

  def index
    @articles = current_user.articles
  end

  def new
    @article = Article.new
  end

  def create
    article = current_user.articles.new(article_params)
    if article.save
      redirect_to article_path(article)
    else 
      redirect_to new_article_path
    end
  end

  def show
    @article = Article.find_by({id: params[:id]})
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      redirect_to article_path(@article)
    else
      redirect_to edit_article_path(@article)
    end
  end

  def destroy
    @article.destroy()
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end

    def set_user_article
      @article = current_user.articles.find_by({id: params[:id]})
      unless @article
        redirect_to articles_path
      end
    end
end
