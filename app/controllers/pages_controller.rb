class PagesController < ApplicationController
  before_action :require_login, only: [:home]
  def home
    @stories = HackerNewsStory.includes(:users, :hacker_news_recommendations).by_popularity.paginate(page: page, per_page: 50)
  end
end
