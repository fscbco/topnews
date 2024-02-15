class StoriesController < ApplicationController

  def index
    top_stories_ids = HackerRankNewsService.new.get_top_stories(15)
    @stories = Story.where(top_stories_ids)
  end

end
