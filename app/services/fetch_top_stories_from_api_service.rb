# frozen_string_literal: true

class FetchTopStoriesFromApiService
  attr_reader :limit

  def initialize(limit:)
    @limit = limit
  end

  def call
    HTTParty.get("https://hacker-news.firebaseio.com/v0/topstories.json").first(limit)
  end
end
