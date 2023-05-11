class Story < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :url, presence: true, uniqueness: true
  validates :story_id, presence: true, uniqueness: true

  has_many :favourite_stories


end