class JobScheduler
  def self.schedule_fetch_job(interval_minutes)
    job_name = 'fetch_news_stories'
    
    Sidekiq.set_schedule(
      job_name,
      {
        'every' => ["#{interval_minutes}m", first_in: '0s'],
        'class' => 'FetchNewsStoriesJob'
      }
    )
    
    Sidekiq::Scheduler.instance.reload_schedule!
    
    Rails.logger.info "Scheduled FetchExternalDataJob to run every #{interval_minutes} minutes"
  end
  
  def self.remove_fetch_job
    job_name = 'fetch_news_stories'
    
    Sidekiq.remove_schedule(job_name)
    
    Sidekiq::Scheduler.instance.reload_schedule!
    
    Rails.logger.info "Removed FetchNewsStoriesJob from schedule"
  end
end