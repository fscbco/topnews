class TopStoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @top_stories = TopStory.all.reject do |story|
      UserStory.where(story_id: story.id, user_id: current_user.id).exists?
    end
  end
end
