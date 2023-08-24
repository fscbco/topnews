class Favorite < ApplicationRecord
  belongs_to :user
  # enforce that a user is associated with a favorite, could check user validity but skipped for time
  validates :user, presence: true
  # enforce that a favorite always has link to a HN post
  validates :post_id, presence: true
end
