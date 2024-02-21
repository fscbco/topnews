# frozen_string_literal: true

class FeedController < ApplicationController
  helper_method :details
  def index
    @top_stories = HTTParty.get("https://hacker-news.firebaseio.com/v0/topstories.json").first(10)
  end

  def details(id:)
    story = Story.find_by(hacker_news_id: id)
    if story.present?
      story
    else
      raw_data = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json").to_h
      hacker_news_id = raw_data.dig("id")
      Story.create(hacker_news_id: hacker_news_id, raw_data: raw_data)
    end
  end
end
