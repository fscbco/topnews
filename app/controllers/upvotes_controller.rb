class UpvotesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    title = params[:title]
    url = params[:url]
    article = Article.find_by(title: title)
    
    if article.present?
      current_user.upvotes.create(article: article)
    else
      article = Article.create(title: title, url: url)
      current_user.upvotes.create(article: article)
    end
    
    redirect_to news_path, notice: "You liked this article: \"#{article[:title]}\"."
  end
end
