class StoriesController < ApplicationController

  def index
    per_page = params[:per_page] || 20
    page     = params[:page] || 1
    @stories = Post.includes(:post_author).desc_stories.paginate(page: page, per_page: per_page)
  end

end
