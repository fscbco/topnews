class Feed < ApplicationRecord
  include PagingConcern

  validates :feed_item_id, :source, :title, :url, presence: true
  # No idea why :source_id displays as "Source can't be blank" (omits "id").
  validates :source_id, presence: { message: "can't be blank" }
  validates :source, length: { maximum: 32 }
  validates :feed_item_id, :source_id, numericality: { only_integer: true }
  validates :published, inclusion: [true, false]

  has_and_belongs_to_many :users, join_table: :user_feeds

  def recommended?
    users.any?
  end

  def recommended_by
    users.map(&:full_name)
  end

  scope :recommended_feed_items, -> {
    where(id: UserFeed.pluck(:feed_id).uniq)
  }
end
