require 'net/http'
require 'uri'

class GetTopStories
  TOP_STORIES_ENDPOINT = URI.parse('https://hacker-news.firebaseio.com/v0/topstories.json')

  class RequestError < StandardError; end

  class << self
    def call
      new.call
    end
  end

  def call
    response = Net::HTTP.get_response(TOP_STORIES_ENDPOINT)
    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      raise RequestError, "Failed to fetch top stories. Error: #{response.error}"
    end
  end
end