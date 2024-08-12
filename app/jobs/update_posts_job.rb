# frozen_string_literal: true

# app/jobs/update_posts_job.rb
# Description: This class is responsible for pulling in new posts from Hackernews. it can be
#              triggered manually or scheduled to run at specific intervals.

class UpdatePostsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    DownloadPostsService.download_stories(100)
  end
end
