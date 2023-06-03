class Story < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  validates :reference_id, presence: true, uniqueness: true

  has_many :user_stories
  has_many :users, through: :user_stories
end

