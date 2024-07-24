namespace :latest_stories do
  desc "Fetch latest stories from Top News API and save them to the database"

  task import: :environment do
    ImportLatestStoriesJob.perform_later
  end
end