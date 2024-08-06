class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @bookmark = current_user.bookmarks.create(article: @article)
    redirect_to @article
  end

  def destroy
    @article = Article.find(params[:article_id])
    @bookmark = current_user.bookmarks.find_by(article: @article)
    @bookmark.destroy
    redirect_to @article
  end
end
