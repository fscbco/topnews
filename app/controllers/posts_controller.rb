class PostsController < ApplicationController
  before_action :authenticate_user!
  after_action :fetch_top_stories, only: %i[index]

  def index
    @posts = Post.includes(:stars, :starred_users).order(hn_created_at: :desc)
    @posts = @posts.where.not(stars: { id: nil }) if params[:filter] == 'starred'
    @posts = @posts.search_by_title(params[:search]) if params[:search].present?
    @posts = @posts.page(params[:page]).without_count
  end

  private

  def fetch_top_stories
    # Since @posts are sorted by hn_created_at, we want to ignore requests from
    # other pages where the first post wouldn't be the latest post
    page = params[:page]&.to_i || 1
    return if page > 1

    # Refresh posts if the last post was fetched more than 3 hours ago
    latest_post = @posts.first
    return unless latest_post && latest_post.hn_created_at < 3.hours.ago

    HackerNews::FetchTopStories.call
  end
end
