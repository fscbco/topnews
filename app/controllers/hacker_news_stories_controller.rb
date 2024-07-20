class HackerNewsStoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stories = HackerNewsStory.includes(:users, :hacker_news_recommendations).by_popularity.paginate(page: page, per_page: 50)
  end
end
