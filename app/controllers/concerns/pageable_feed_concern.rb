module PageableFeedConcern
  extend ActiveSupport::Concern
  include PageableConcern

  private

  def initialize_pageable_feed
    page = params[:page]&.to_i || 1

    feed_items = Feed.for_page(:title, page, items_per_page)
    feed_items = Kaminari.paginate_array(feed_items, total_count: Feed.count).page(page).per(items_per_page)
    @feed = FeedPresenter.new(feed_items: feed_items, current_user: current_user)
  end
end
