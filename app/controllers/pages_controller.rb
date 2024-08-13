class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    top_story_ids = HackerNews.new.top_stories.first(10)
    @top_stories = Story.find_or_create_by_hacker_news_ids(top_story_ids)
  end

  def recommendations
    @recent_stories = Story.joins(:recommendations)
                           .select('stories.*, MAX(recommendations.created_at) as latest_recommendation')
                           .group('stories.id')
                           .order('latest_recommendation DESC')
                           .limit(10)

    @recent_stories = @recent_stories.includes(recommendations: :user)
  end
end
