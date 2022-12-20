module FeedHelper
  def feed_container_class
    "feed-container"
  end

  def recommended_feed_container_class
    "recommended-feed-container"
  end

  def feed_item_action_button_container_css_class(feed_item_id)
    "feed-item-btn-#{feed_item_id}-container"
  end

  def recommended_feed_item_action_button_container_css_class(feed_item_id)
    "recommended-feed-item-btn-#{feed_item_id}-container"
  end

  def recommended_feed_item_container_css_class(feed_item_id)
    "recommended-feed-item-#{feed_item_id}-container"
  end
end
