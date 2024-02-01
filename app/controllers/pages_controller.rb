require_relative '../services/hacker_news.rb'

class PagesController < ApplicationController
  def home
    @stories = HackerNews.top_stories
  end
end
