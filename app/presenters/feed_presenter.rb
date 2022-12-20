class FeedPresenter
  attr_reader :feed_items, :current_user, :pager_params

  delegate :any?, :count, to: :feed_items

  def initialize(feed_items:, current_user:)
    @feed_items = feed_items
    @current_user = current_user
    load_feed_items!
  end

  # To make Rails understand what partials to use for this presenter
  def name
    'Feed'
  end

  def to_partial_path
    "shared/#{name.downcase}"
  end

  private

  def load_feed_items!
    @feed_items.each_with_index { |feed_item, index| @feed_items[index] = FeedItemPresenter.new(feed_item: feed_item, current_user: current_user) }
  end
end
