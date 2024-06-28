# frozen_string_literal: true

class StoryProcessor
  def save_stories(stories_data)
    return if stories_data.empty?

    attributes = prepare_attributes(stories_data)
    Story.upsert_all(attributes, unique_by: :hacker_news_id)
  end

  private

  def prepare_attributes(stories_data)
    stories_data.map do |story_data|
      puts "story_data: #{story_data['id']}"
      {
        hacker_news_id: story_data['id'],
        author: story_data['by'],
        time: Time.at(story_data['time']),
        title: story_data['title'],
        url: story_data['url']
      }
    end
  end
end
