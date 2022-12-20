module RecommendedFeedItemConcern
  extend ActiveSupport::Concern

  # Unrecommends (destroys) the recommended feed item if the feed
  # feed item is already recommended; otherwise, it will recommend
  # (add) the feed item.
  def toggle_feed_item_recommended(id)
    Rails.logger.warn("xyzzy: toggle_feed_item_recommended")
    return unrecommend_feed_item(id) if feed_item_recommended?(id)

    recommend_feed_item(id)
  end

  def feed_item_recommended?(id)
    feeds.where(id: id).exists?
  end

  def recommend_feed_item(id)
    Rails.logger.warn("xyzzy: recommend_feed_item")
    feed_item = Feed.find(id)
    feeds << feed_item
    feed_item
  end

  def unrecommend_feed_item(id)
    Rails.logger.warn("xyzzy: unrecommend_feed_item")
    feed_item = Feed.find(id)
    feeds.delete(feed_item)
    feed_item
  end
end
