# frozen_string_literal: true

require 'httparty'

class StoryFetcher
  include HTTParty

  base_uri 'https://hacker-news.firebaseio.com/v0'

  def initialize(options = {})
    @options = options
  end

  def fetch_story(story_id)
    response = self.class.get("/item/#{story_id}.json", @options)
    response.parsed_response if response.success?
  end

  def top_stories_ids
    self.class.get('/topstories.json', @options) || []
  end
end
