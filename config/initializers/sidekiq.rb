require 'sidekiq'
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' } # Update the Redis URL as needed
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' } # Update the Redis URL as needed
end
