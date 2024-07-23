class FetchTopStoriesService
  require 'net/http'
  require 'json'

  TOP_STORIES_URL = 'https://hacker-news.firebaseio.com/v0/topstories.json'
  STORY_URL = 'https://hacker-news.firebaseio.com/v0/item/'

  def self.call
    story_ids = fetch_top_story_ids.first(30)
    story_ids.map { |id| fetch_story_details(id) }
  end

  def self.fetch_top_story_ids
    response = Net::HTTP.get(URI(TOP_STORIES_URL))
    JSON.parse(response)
  end

  def self.fetch_story_details(story_id)
    Rails.cache.fetch("story_#{story_id}", expires_in: 1.day) do
      Rails.logger.info "Cache miss for story_id: #{story_id}. Fetching from API."
      response = Net::HTTP.get(URI("#{STORY_URL}#{story_id}.json"))
      JSON.parse(response)
    end
  end
end

