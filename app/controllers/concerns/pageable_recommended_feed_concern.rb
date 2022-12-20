module PageableRecommendedFeedConcern
  extend ActiveSupport::Concern
  include PageableConcern

  private

  def initialize_pageable_recommended_feed
    page = params[:page]&.to_i || 1
    initialize_pageable_recommended_feed_for page
  end

  # Recursion here is simply to handle a case when we're on the last page
  # of recommended items, and the user unrecommends the last item on the
  # last page; this handles going to the previous page.
  def initialize_pageable_recommended_feed_for(page)
    feed_items = Feed.recommended_feed_items.for_page(:title, page, items_per_page)
    if feed_items.empty? && page.positive?
      page = page - 1
      initialize_pageable_recommended_feed_for page
      return
    end
    feed_items = Kaminari.paginate_array(feed_items, total_count: Feed.recommended_feed_items.count).page(page).per(items_per_page)
    @feed = RecommendedFeedPresenter.new(feed_items: feed_items, current_user: current_user)
  end
end
