class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @articles = Article.order(created_at: :desc)[0..100] # artificial limit
  end
  
  # def show
  # end
  
  # def new
  #   @article = Article.new
  # end
  
  # def create
  #   @article = Article.new(article_params)
    
  #   if @article.save
  #     redirect_to @article, notice: 'Article was successfully created.'
  #   else
  #     render :new
  #   end
  # end
  
  # def edit
  # end
  
  # def update
  #   if @article.update(article_params)
  #     redirect_to @article, notice: 'Article was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end
  
  # def destroy
  #   @article.destroy
  #   redirect_to articles_url, notice: 'Article was successfully destroyed.'
  # end
  
  def refresh
    FetchTopStoriesJob.perform_later
    redirect_to root_path, notice: 'Data is being refreshed.'
  end

end
