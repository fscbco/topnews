class StoriesController < ApplicationController
  def index
    @stories = Story.where(hr_news_story: true)
  end
end
