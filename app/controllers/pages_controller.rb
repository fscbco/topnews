class PagesController < ApplicationController
  before_action :require_login, only: [:home]
  def home
    @stories = HackerNewsStory.by_popularity
  end
end
