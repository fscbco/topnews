class StoriesController < ApplicationController
  def index
    @story_ids = Like.all.pluck(:story_id)
    @story_ids += HackerNews::TopStoriesService.new.call.first(20)
    @story_ids.uniq
  end

  def show
    story = HackerNews::ItemService.new(params[:id]).call
    @story = Story.new(id: story[:id], title: story[:title], url: story[:url], by: story[:by])
  end

end
