#frozen_string_literal: true

require 'net/http'
require 'uri'

class GetStory
  ITEM_ENDPOINT = "https://hacker-news.firebaseio.com/v0/item/"

  class RequestError < StandardError; end

  class << self
    def call(*args)
      new(*args).call
    end
  end

  def initialize(story_id)
    @story_id = story_id
  end

  def call
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      raise RequestError, "Failed to fetch story #{@story_id}. Error: #{response.error}"
    end
  end

  def uri
    URI.parse("#{ITEM_ENDPOINT}#{@story_id}.json")
  end
end