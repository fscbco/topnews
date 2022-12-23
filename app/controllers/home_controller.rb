class HomeController < ApplicationController
  include PageableFeedConcern
  include PollFeedsJobConcern

  before_action :authenticate_user!
  # Poll until the feeds job is completed (if it's running), or
  # force the feed job to run if we have no feeds.
  before_action :poll_feeds_job, if: -> { poll_feeds_job? }

  def show
    respond_to do |format|
      format.html {
        initialize_pageable_feed
      }
      format.js {
        @feed_item = FeedItemPresenter.new(
          feed_item: current_user.toggle_feed_item_recommended(params[:id]),
          current_user: current_user,
        )
      }
    end
  end

  private

  def poll_feeds_job?
    return true if helpers.feed_update_running?
    return PullFeedsJob.perform_async if Feed.none?
  end
end
