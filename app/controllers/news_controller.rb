class NewsController < ApplicationController
  def index
    first_top_stories = HackerNews.new.top_stories.first(10)
    @top_stories = first_top_stories.map do |id|
      HackerNews.new.item(id)
    end
  end
end
