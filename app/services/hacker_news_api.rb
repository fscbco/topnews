# frozen_string_literal: true

# Service class for interacting with Hacker News API to fetch and save stories.
#
# This class provides methods to fetch the top stories from Hacker News API
# and save them into the database.
#
# Example usage:
#   api = HackerNewsApi.new(max_stories: 20)
#   api.fetch_stories
#
class HackerNewsApi
  # Initializes a new instance of HackerNewsApi.
  #
  # @param fetcher [StoryFetcher] The fetcher object to fetch stories from Hacker News API.
  # @param processor [StoryProcessor] The processor object to save stories into the database.
  # @param max_stories [Integer] The maximum number of stories to fetch.
  def initialize(
    fetcher: StoryFetcher.new,
    processor: StoryProcessor.new,
    max_stories: 20
  )
    @fetcher = fetcher
    @processor = processor
    @max_stories = max_stories
  end

  # Fetches and saves stories from Hacker News API.
  #
  # This method fetches only up to max_stories number of stories,
  # processes them concurrently using threads, and saves them into the database.
  #
  # @return [void]
  def fetch_stories
    story_ids = @fetcher.top_stories_ids[0...@max_stories]
    threads = create_fetch_threads(story_ids)
    join_threads(threads)

    stories_data = threads.map(&:value).compact
    save_stories(stories_data)
  end

  # Saves the fetched stories data into the database.
  #
  # This method will save the stories data into the database unless the data is empty.
  #
  # @param stories_data [Array<Hash>] The array of story data hashes to be saved.
  # @return [void]
  def save_stories(stories_data)
    save_stories_data(stories_data) unless stories_data.empty?
  end

  private

  # Creates threads for fetching stories concurrently.
  #
  # @param story_ids [Array<Integer>] Array of story IDs to fetch concurrently.
  # @return [Array<Thread>] Array of Thread objects created for concurrent fetching.
  def create_fetch_threads(story_ids)
    story_ids.map do |story_id|
      Thread.new { fetch_story_data(story_id) }
    end
  end

  # Fetches data for a single story from Hacker News API.
  #
  # @param story_id [Integer] The ID of the story to fetch.
  # @return [Hash, nil] Story data hash if fetch successful, nil otherwise.
  def fetch_story_data(story_id)
    @fetcher.fetch_story(story_id)
  end

  # Joins threads and retrieves results from them.
  #
  # @param threads [Array<Thread>] Array of Thread objects to join.
  # @return [Array<Hash>] Array of story data hashes fetched from threads.
  def join_threads(threads)
    threads.map(&:value).compact
  end

  # Saves stories data into the database using the processor object.
  #
  # @param stories_data [Array<Hash>] Array of story data hashes to save.
  # @return [void]
  def save_stories_data(stories_data)
    @processor.save_stories(stories_data)
  end
end
