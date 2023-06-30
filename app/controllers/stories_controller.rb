class StoriesController < ApplicationController
 def index
  all_stories = HackerNewsApi.get_all_stories
  sorted_stories = all_stories.sort.reverse
  @top_stories = sorted_stories.take(10)
 end

 def show
   @story = HackerNewsApi.get_story_details(params[:id])
 end
end
