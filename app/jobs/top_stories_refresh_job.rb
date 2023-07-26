class TopStoriesRefreshJob < ApplicationJob
  queue_as :default

  def perform(*args)
    TopStoriesService.fetch_and_save_top_stories
  end
end
