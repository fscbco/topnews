class StoriesController < ApplicationController
  before_action :authenticate_user!

  def view
    @stories = StoryRanking.top_stories
  end

  def recommendations
    @stories = Recommendation.stories
  end
end
