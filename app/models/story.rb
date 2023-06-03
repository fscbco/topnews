class Story < ApplicationRecord
  has_many :likes, dependent: :destroy
  scope :with_likes, -> { joins(:likes).distinct }

  def get_likes
    likes.map { |like| like.user.first_name }
  end
end
