class NewsController < ApplicationController
  def index
    @stories = NewsService.fetch_stories
  end
end
