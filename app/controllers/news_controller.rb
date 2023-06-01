class NewsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  private

  def fetch_news_stories
  end
end
