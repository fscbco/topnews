# frozen_string_literal: true

# app/clients/hacker_news_client.rb
# Description: This class is responsible for fetching the top stories and story
# details from theHacker News API.

class HackerNewsClient
  class << self
    def fetch_top_stories
      response = RestClient.get('https://hacker-news.firebaseio.com/v0/topstories.json')
      JSON.parse(response.body)
    end

    def fetch_story_details(id)
      response = RestClient.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
      JSON.parse(response.body)
    end

    def fetch_top_stories_details(limit=20)
      top_stories = fetch_top_stories.first(limit)
      top_stories.map { |id| fetch_story_details(id).except('kids', 'descendants') }
    end
  end
end
