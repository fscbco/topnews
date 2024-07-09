require 'net/http'
require 'json'

class HackerNewsService
  TOP_STORIES_URL = 'https://hacker-news.firebaseio.com/v0/topstories.json'
  STORY_URL = 'https://hacker-news.firebaseio.com/v0/item/%{id}.json'

  def fetch_top_stories(limit = 20)
    story_ids = fetch_story_ids
    story_ids.first(limit).map { |id| fetch_story(id) }
  end

  def fetch_story(id)
    url = STORY_URL % { id: id }
    response = HTTParty.get(url)
    response.parsed_response
  end

  private

  def fetch_story_ids
    response = HTTParty.get(TOP_STORIES_URL)
    response.parsed_response
  end
end
