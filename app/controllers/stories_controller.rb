class StoriesController < ApplicationController
 def index
  all_stories = HackerNewsApi.get_top_stories

  @top_stories = all_stories.take(10)
 end

 def show
   @story = HackerNewsApi.get_story_details(params[:id])
 end
end
