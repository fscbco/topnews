require 'HackerNewsClient'

class HackernewsJob < ApplicationJob
  queue_as :default
  RUN_EVERY = 1.hour

  # This job fetches the top stories from HackerNews and upserts them into the local database,
  # associating each story with its rank.
  # It uses HackerNewsClient to fetch data and Story/StoryRanking models for storage.
  # Note: This functionality is dependent on a queue adapter backend to handle delayed job scheduling.

  def perform(*args)
    top_stories = HackerNewsClient.get_top_stories(20)
    rank = 1

    top_stories.each do |hn_story|
      story = Story.upsert(
        { title: hn_story['title'], url: hn_story['url'], hn_story_id: hn_story['id'] },
        unique_by: :hn_story_id
      )
      # ideally the rankings could be stored and updated as a sorted set (ZSET) in redis
      # To keep things simple, use a database table to store the rankings
      StoryRanking.upsert({ story_id: story[0]['id'], rank: rank }, unique_by: [:story_id, :rank])
      rank += 1
    end

    # Uncomment once a queue adapter backend is defined and configured
    # self.class.perform_later(wait: RUN_EVERY)
  end
end
