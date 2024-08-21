Rails.application.config.after_initialize do
  if defined?(Sidekiq::Scheduler)
    Sidekiq::Scheduler.instance.reload_schedule!
    Rails.logger.info "Scheduled FetchNewsStoriesJob to run every #{ENV.fetch('POLLING_INTERVAL', '1m')}"
  else
    Rails.logger.warn "Sidekiq::Scheduler not available. FetchNewsStoriesJob not scheduled."
  end
end