class StoriesController < ApplicationController

  def index
    @stories = Story.find(HackerRankNews.new.get_top_stories.first(10))
  end

end
