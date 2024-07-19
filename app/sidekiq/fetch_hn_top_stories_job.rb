class FetchHnTopStoriesJob
  include Sidekiq::Job

  def perform
    client = HackerNewsClient.new
    top_story_ids = client.top_story_ids
    saved_story_ids = HackerNewsStory.pluck(:hacker_news_id)

    ids_to_fetch = top_story_ids - saved_story_ids
    ids_to_fetch.each { |id| RecordHnItemJob.perform_async(id) }
  end
end
