class UserStoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    UserStory.create!(story_id: params[:story_id], user_id: current_user.id)
    redirect_to top_stories_path
  end
end
