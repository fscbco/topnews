# frozen_string_literal: true

class FeedController < ApplicationController
  helper_method :details
  def index
    @top_stories = HTTParty.get("https://hacker-news.firebaseio.com/v0/topstories.json").first(10)
  end

  def details(id:)
    HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
  end
end
