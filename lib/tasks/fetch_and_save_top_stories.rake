namespace :hacker_news do
  desc "Fetch top stories from Hacker News API and save stories"
  # rake hacker_news:fetch_and_save_top_stories 
  # this rake task can be added to Heroku scheduler 
  # https://elements.heroku.com/addons/scheduler
  # it can be ran hourly or daily as needed to fetch updated data
  task fetch_and_save_top_stories: :environment do
      FetchTopStoriesJob.perform_later
  end
end

