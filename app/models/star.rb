class Star < ApplicationRecord
  validates :user, presence: true, uniqueness: { scope: :post_id }
  validates :post, presence: true

  belongs_to :user
  belongs_to :post
end
