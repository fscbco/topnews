# Run: rails cron:download_posts 
# Description: can be executed from cronjob to update the posts from Hacker News

namespace :cron do
  desc 'Download posts'
  task download_posts: :environment do
    Rails.logger.info 'Launching start_of_every_hour task'
    DownloadPostsService.download_stories(100)
  end
end
