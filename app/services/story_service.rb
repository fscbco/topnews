# frozen_string_literal: true

class StoryService
  def self.fetch_stories
    response = HTTParty.get('https://hacker-news.firebaseio.com/v0/topstories.json')

    return JSON.parse(response.body)[0..10] if response.code == 200

    nil
  end

  def self.fetch_story(id)
    response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json")

    return JSON.parse(response.body) if response.code == 200

    nil
  end

  def self.fetch_stories_details(story_ids)
    return if story_ids.blank?

    story_ids.map do |id|
      fetch_story(id)
    end
  end
end
