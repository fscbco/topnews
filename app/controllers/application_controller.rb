class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :schedule_top_stories_refresh_job
  private

  def schedule_top_stories_refresh_job
    TopStoriesRefreshJob.set(wait: 5.minutes).perform_later
    puts("FEED UPDATED")
  end
end
