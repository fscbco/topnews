class HackerNewsStory < ApplicationRecord
  validates :hacker_news_id, presence: true, uniqueness: true
  validates :author, presence: true
  validates :score, presence: true
  validates :hacker_news_timestamp, presence: true
  validates :title, presence: true
  validates :url, presence: true
end
