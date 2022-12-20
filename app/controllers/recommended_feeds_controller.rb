class RecommendedFeedsController < ApplicationController
  include PageableRecommendedFeedConcern

  before_action :authenticate_user!

  def show
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
