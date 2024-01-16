class UserStoriesController < ApplicationController
  def index
    @user_stories = NewsService.fetch_stories
  end

  def create
    NewsService.create_new_like(story_id: params[:format], user_id: current_user.id)
  end
end
