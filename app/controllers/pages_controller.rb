require_relative '../services/hacker_news.rb'

class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    @stories = HackerNews.top_stories
  end
end
