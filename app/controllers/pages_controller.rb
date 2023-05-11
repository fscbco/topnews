class PagesController < ApplicationController
  def index
    @stories = Story.includes(:favourite_stories).order(story_time: :desc, score: :desc).limit(10)
  end
end
