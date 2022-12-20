class RecommendedFeedItemPresenter < FeedItemPresenter
  def name
    'RecommendedFeedItem'
  end

  def to_partial_path
    "shared/#{name.underscore}"
  end
end
