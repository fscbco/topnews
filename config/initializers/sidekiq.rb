# config/initializers/sidekiq.rb
require 'sidekiq'
require 'sidekiq-cron'

# Create a new cron job for fetching and storing stories
Sidekiq::Cron::Job.create(
  name: 'Fetch and Store Stories - every 1 minute',
  cron: '*/1 * * * *', # Cron schedule (every 1 minute)
  class: 'FetchAndStoreStoriesWorker' # The worker class to run
)
