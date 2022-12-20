class FeedItemPresenter
  attr_reader :feed_item, :current_user

  delegate :id, :recommended_by, :recommended?, :source, :title, :url, :users, :user_feeds, to: :feed_item

  def initialize(feed_item:, current_user:)
    @feed_item = feed_item
    @current_user = current_user
  end

  def recommended_by_user?
    recommended_by_user
  end

  def recommended_by_user
    @recommended_by_user ||= feed_item.users.any?
  end

  def recommended_by_current_user?
    recommended_by_current_user
  end

  def recommended_by_current_user
    @recommended_by_current_user ||= current_user.feed_item_recommended?(feed_item.id)
  end

  def name
    'FeedItem'
  end

  def to_partial_path
    "shared/#{name.underscore}"
  end
end
