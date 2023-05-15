class NewsController < ApplicationController
  before_action :load_news, only: [:index]

  def index
    @news = load_news
  end

  private
  
  def load_news
    top_ten_news_ids.map do |id|
      story_url = "https://hacker-news.firebaseio.com/v0/item/#{id}.json"

      api_call(story_url)
    end
  end

  def top_ten_news_ids
    all_news_ids.slice(0, 10)
  end

  def all_news_ids
    @all_news_ids ||= api_call("https://hacker-news.firebaseio.com/v0/topstories.json")
  end

  def api_call (url)
    JSON.parse(Net::HTTP.get(URI.parse(url)))
  end

end