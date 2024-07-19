class HackerNewsStory < ApplicationRecord
  has_many :hacker_news_recommendations, dependent: :destroy
  has_many :users, through: :hacker_news_recommendations

  alias_attribute :recommended_by, :users

  validates :hacker_news_id, presence: true, uniqueness: true
  validates :author, :score, :hacker_news_timestamp, :title, :url, presence: true
end
