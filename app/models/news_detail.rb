class NewsDetail < ApplicationRecord
  scope :most_recent_story, -> { order(hn_id: :desc).limit(1).first }

  validates :hn_id, uniqueness: true

  has_and_belongs_to_many :users
end
