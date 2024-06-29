# frozen_string_literal: true

require 'httparty'

# Service class for fetching stories from Hacker News API.
#
# This class provides methods to fetch story details and top story IDs
# from Hacker News API.
#
# Example usage:
#   fetcher = StoryFetcher.new
#   fetcher.fetch_story(123) #=> Returns story details with ID 123
#   fetcher.top_stories_ids #=> Returns an array of top story IDs
#
class StoryFetcher
  include HTTParty

  base_uri 'https://hacker-news.firebaseio.com/v0'

  # Initializes a new instance of StoryFetcher.
  #
  # @param options [Hash] Optional configuration options for HTTParty.
  def initialize(options = {})
    @options = options
  end

  # Fetches details of a story from Hacker News API.
  #
  # @param story_id [Integer] The ID of the story to fetch.
  # @return [Hash, nil] Story data hash if fetch successful, nil otherwise.
  def fetch_story(story_id)
    response = self.class.get("/item/#{story_id}.json", @options)
    response.parsed_response if response.success?
  end

  # Fetches IDs of top stories from Hacker News API.
  #
  # @return [Array<Integer>] Array of top story IDs.
  def top_stories_ids
    self.class.get('/topstories.json', @options) || []
  end
end
