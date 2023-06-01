require 'httparty'

class NewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @news_stories = fetch_news_stories
    @articles = Article.includes(:upvoters).all
  end

  private

  def fetch_news_stories
    hackernews_stories_endpoint = 'https://hacker-news.firebaseio.com/v0/topstories.json'
    response = HTTParty.get(hackernews_stories_endpoint)
    story_ids = JSON.parse(response.body)

    news_stories = []

    story_ids.take(40).each do |story_id|
      story_endpoint = "https://hacker-news.firebaseio.com/v0/item/#{story_id}.json"
      story_response = HTTParty.get(story_endpoint)
      story_data = JSON.parse(story_response.body)

      news_stories << {
        id: story_data['id'],
        title: story_data['title'],
        url: story_data['url'],
        score: story_data['score'],
        comments_count: story_data['descendeants']
      }
    end
    news_stories
  end
end
