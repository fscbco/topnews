class Story < ApplicationRecord
  has_many :likes
  has_many :users, through: :likes

  validates :title, :url, :hacker_news_id, presence: true
  validates :hacker_news_id, uniqueness: true
end
