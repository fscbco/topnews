# frozen_string_literal: true

class HackerNewsApi
  def initialize(fetcher: StoryFetcher.new, processor: StoryProcessor.new, max_stories: 20)
    @fetcher = fetcher
    @processor = processor
    @max_stories = max_stories
  end

  def fetch_stories
    # fetch only max_stories number of stories
    story_ids = @fetcher.top_stories_ids[0...@max_stories]
    threads = create_fetch_threads(story_ids)

    join_threads(threads)
  end

  def save_stories(stories_data)
    save_stories_data(stories_data) unless stories_data.empty?
  end

  private

  def create_fetch_threads(story_ids)
    story_ids.map do |story_id|
      Thread.new { fetch_story_data(story_id) }
    end
  end

  def fetch_story_data(story_id)
    @fetcher.fetch_story(story_id)
  end

  def join_threads(threads)
    threads.map(&:value).compact
  end

  def save_stories_data(stories_data)
    @processor.save_stories(stories_data)
  end
end
