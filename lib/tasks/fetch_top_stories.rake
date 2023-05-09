namespace :top_news do
    desc "Fetch top stories from Hacker News API"
    task fetch_top_stories: :environment do
        # FetchTopStoriesJob.perform_later (to be used with Sidekiq, Delayed Job, or Resque set up to process the jobs)
        FetchTopStoriesJob.perform_now
    end
  end
