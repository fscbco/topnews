require 'rest-client'
require 'json'

class HackerNews
  BASE_URL = 'https://hacker-news.firebaseio.com/v0/'

  def self.top_stories(limit = 30)
    response = RestClient.get("#{BASE_URL}topstories.json?print=pretty")
    story_ids = JSON.parse(response.body).first(limit)

    story_ids.map do |story_id|
      response = RestClient.get("#{BASE_URL}item/#{story_id}.json?print=pretty")
      JSON.parse(response.body)
    end
  end
end