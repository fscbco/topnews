# frozen_string_literal: true

class NewsFeedService
    def self.fetch_top_news
      response = HTTParty.get('https://hacker-news.firebaseio.com/v0/topstories.json')
      return JSON.parse(response.body)[0..24] if response.code == 200
      return if responose.code == 404 || return if respose.code == 500
      nil
    end
  
    def self.fetch_each_news(id)
      response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
      return JSON.parse(response.body) if response.code == 200
      return if responose.code == 404 || return if respose.code == 500
      nil
    end
  
    def self.fetch_info(news_ids)
      return if news_ids.blank?
      news_ids.map do |id|
        fetch_each_news(id)
      end
    end
  end
  