class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    first_top_stories = HackerNews.new.top_stories.first(10)
    @top_stories = first_top_stories.map do |id|
      HackerNews.new.item(id)
    end
  end
end
