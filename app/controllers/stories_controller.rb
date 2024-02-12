class StoriesController < ApplicationController
  def index
    @stories = Story.all.includes(:starred_by_users)
    @top_stories = @stories.filter{|story| story.story_stars.any? }
  end
end
