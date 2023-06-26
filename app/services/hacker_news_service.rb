require 'net/http'
require 'json'

class HackerNewsService
  BASE_URL = 'https://hacker-news.firebaseio.com/v0'

  def top_stories
    response = Net::HTTP.get(URI("#{BASE_URL}/topstories.json"))
    story_ids = JSON.parse(response).first(10)
    story_ids.map do |id|
      response = Net::HTTP.get(URI("#{BASE_URL}/item/#{id}.json"))
      JSON.parse(response)
    end
  end
end
