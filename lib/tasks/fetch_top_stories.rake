# Ideally, this would be run at an interval (i.e. every 30 min) via a cron job
desc 'Fetch top stories from HackerNews and create Posts'
task fetch_top_stories: :environment do
  HackerNews::FetchTopStories.call
end
