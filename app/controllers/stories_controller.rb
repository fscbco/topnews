class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stories = StoryFetcherService.fetch_top_stories(10)
  end
end
