desc 'Fetch top stories from HackerNews and create Posts'
task fetch_top_stories: :environment do
  HackerNews::FetchTopStories.call
end
