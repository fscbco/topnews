class RecommendedFeedsController < ApplicationController
  include PageableRecommendedFeedConcern
  include PollFeedsJobConcern

  before_action :authenticate_user!
  before_action :poll_feeds_job, if: -> { helpers.feed_update_running? }

  def index
    respond_to do |format|
      format.html { initialize_pageable_recommended_feed }
      format.js {
        @feed_item = RecommendedFeedItemPresenter.new(
          feed_item: current_user.toggle_feed_item_recommended(params[:id]),
          current_user: current_user,
        )
      }
    end
  end
end
