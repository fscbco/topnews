class Story < ApplicationRecord
  has_many :user_stories
  has_many :users, through: :user_stories

  validates :hn_id, presence: true, uniqueness: true
  validates :title, presence: true
  validates :url, presence: true
end