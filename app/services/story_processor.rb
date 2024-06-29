# frozen_string_literal: true

# Service class for processing and saving stories into the database.
#
# This class provides methods to save fetched story data into the database using
# upsert operations.
#
# Example usage:
#   processor = StoryProcessor.new
#   processor.save_stories(stories_data) #=> Saves stories_data into the database
#
class StoryProcessor
  # Saves stories data into the database using upsert operations.
  #
  # @param stories_data [Array<Hash>] Array of story data hashes to save.
  # @return [void]
  def save_stories(stories_data)
    return if stories_data.empty?

    attributes = prepare_attributes(stories_data)
    Story.upsert_all(attributes, unique_by: :hacker_news_id)
  end

  private

  # Prepares attributes for upsert operation from fetched stories data.
  #
  # @param stories_data [Array<Hash>] Array of story data hashes to prepare
  #   attributes for.
  # @return [Array<Hash>] Array of prepared attributes for upsert operation.
  def prepare_attributes(stories_data)
    stories_data.map do |story_data|
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
