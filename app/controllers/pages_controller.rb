class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    top_story_ids = HackerNews.new.top_stories.first(10)
    @top_stories = Story.find_or_create_by_hacker_news_ids(top_story_ids)
  end
end
