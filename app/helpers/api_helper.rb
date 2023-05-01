# frozen_string_literal: true

module ApiHelper
  STORY_URL = 'https://hacker-news.firebaseio.com/v0/item/'
  TOP_STORIES_URL = 'https://hacker-news.firebaseio.com/v0/topstories.json'
  NUM_OF_STORIES = 20

  def self.fetch_full_stories
    story_ids = fetch_top_stories_ids
    story_ids.map { |id| fetch_and_create_story(id) }
  end

  def self.fetch_top_stories_ids
    uri = URI(TOP_STORIES_URL)
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      json = JSON.parse(response.body)
      json.last(NUM_OF_STORIES)

    else
      Rails.logger.error("Unable to fetch top stories: #{response.code} - #{response.message}")
      raise 'Unable to fetch top stories'
    end
  end

  def self.fetch_and_create_story(id)
    uri = URI("#{STORY_URL}#{id}.json")
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      story = JSON.parse(response.body)
      self.create_story(story)
    else
      Rails.logger.error("Unable to fetch story: #{response.code} - #{response.message}")
      raise 'Unable to fetch story'
    end
  end

  def self.create_story(story)
    Story.find_or_create_by!(hn_id: story['id']) do |story_db|
      story_db.title = story['title']
      story_db.url = story['url']
    end
  end
end
