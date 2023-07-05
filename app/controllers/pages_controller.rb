class PagesController < ApplicationController
  def home
    @stories = HackerNewsService.new.top_stories
  end
end
