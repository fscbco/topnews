class HackerNewsStory < ApplicationRecord
  has_many :hacker_news_recommendations, dependent: :destroy
  has_many :users, through: :hacker_news_recommendations, counter_cache: true, source: :user

  alias_attribute :recommended_by, :users
  alias_attribute :recommendations, :hacker_news_recommendations

  validates :hacker_news_id, presence: true, uniqueness: true
  validates :author, :score, :hacker_news_timestamp, :title, :url, presence: true

  scope :by_popularity, -> { order(recommendations_count: :desc, score: :desc) }
end
