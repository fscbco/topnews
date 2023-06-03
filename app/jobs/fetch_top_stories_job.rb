class FetchTopStoriesJob < ApplicationJob
  queue_as :default

  def perform
    HackerNews.fetch_and_save_to_stories
  end
end

