class StoryFetcherService
  require 'httparty'

  TOP_STORIES_URL = 'https://hacker-news.firebaseio.com/v0/topstories.json'.freeze
  STORY_DETAILS_URL = 'https://hacker-news.firebaseio.com/v0/item/%{id}.json'.freeze

  def self.fetch_top_stories(limit = 10)
    story_ids = fetch_top_story_ids.take(limit)
    story_ids.map { |id| fetch_story_details(id) }
  end

  def self.fetch_top_story_ids
    response = HTTParty.get(TOP_STORIES_URL)
    response.parsed_response
  end

  def self.fetch_story_details(id)
    response = HTTParty.get(STORY_DETAILS_URL % { id: id })
    transform_story_data(response.parsed_response)
  end

  def self.transform_story_data(story_data)
    {
      id: story_data['id'],
      title: story_data['title'],
      author: story_data['by'],
      type: story_data['type'],
      published_at: Time.at(story_data['time']),
      url: story_data['url']
    }
  end
end
