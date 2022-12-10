class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.includes(:stars, :starred_users).order(:created_at)
    @posts = @posts.where.not(stars: { id: nil }) if params[:filter] == 'starred'
    @posts = @posts.page(params[:page]).without_count
  end
end
