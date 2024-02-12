class Story < ApplicationRecord
  validates :external_id, presence: true
  validates :title, presence: true
  validates :author, presence: true

  has_many :story_stars
  has_many :starred_by_users, through: :story_stars, source: :user
end
