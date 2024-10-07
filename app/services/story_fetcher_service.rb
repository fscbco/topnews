class StoryFetcherService
  require 'httparty'

  STORY_LIST_KEY = 'stories:top_news'.freeze
  TOP_STORIES_URL = 'https://hacker-news.firebaseio.com/v0/topstories.json'.freeze
  STORY_DETAILS_URL = 'https://hacker-news.firebaseio.com/v0/item/%{id}.json'.freeze

  def self.perform
    new.perform
  end

  def perform
    stories = fetch_top_stories
    store_stories_in_redis(stories)
    store_stories_in_db(stories)
  end

  private

  def fetch_top_stories(limit = 10)
    story_ids = fetch_top_story_ids.take(limit)
    story_ids.map { |id| fetch_story_details(id) }
  end

  def fetch_top_story_ids
    response = HTTParty.get(TOP_STORIES_URL)
    response.parsed_response
  end

  def fetch_story_details(id)
    response = HTTParty.get(STORY_DETAILS_URL % { id: id })
    transform_story_data(response.parsed_response)
  end

  def transform_story_data(story_data)
    {
      id: story_data['id'],
      title: story_data['title'],
      author: story_data['by'],
      type: story_data['type'],
      published_at: story_data['time'],
      url: story_data['url']
    }
  end

  def store_stories_in_redis(stories)
    $redis.multi do
      $redis.del(STORY_LIST_KEY)
      stories.each do |story|
        $redis.rpush(STORY_LIST_KEY, story.to_json)
      end
    end
  end

  def store_stories_in_db(stories)
    stories.each do |story|
      db_story = Story.find_or_initialize_by(id: story[:id])
      db_story.update(
        title: story[:title],
        url: story[:url],
        author: story[:author],
        story_type: story[:type],
        published_at: Time.at(story[:published_at])
      )
    end
  end
end
