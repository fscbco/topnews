class PagesController < ApplicationController
  include PageableFeedConcern

  before_action :authenticate_user!

  def home
    respond_to do |format|
      format.html { initialize_pageable_feed }
      format.js {
        @feed_item = FeedItemPresenter.new(
          feed_item: current_user.toggle_feed_item_recommended(params[:id]),
          current_user: current_user,
        )
      }
    end
  end
end
