module PollFeedsJobConcern
  extend ActiveSupport::Concern

  private

  def poll_feeds_job
    redirect_to poll_feeds_path(redirect_path: request.path)
  end
end
