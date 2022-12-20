class RecommendedFeedPresenter < FeedPresenter
  def name
    'RecommendedFeed'
  end

  def to_partial_path
    "shared/#{name.underscore}"
  end

  private

  def load_feed_items!
    @feed_items.each_with_index { |feed_item, index| @feed_items[index] = RecommendedFeedItemPresenter.new(feed_item: feed_item, current_user: current_user) }
  end
end
