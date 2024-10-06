# app/workers/fetch_and_store_stories_worker.rb
class FetchAndStoreStoriesWorker
  include Sidekiq::Worker

  def perform
    StoryFetcherService.perform
  end
end
