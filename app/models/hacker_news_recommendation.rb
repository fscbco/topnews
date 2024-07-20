class HackerNewsRecommendation < ApplicationRecord
  belongs_to :user
  belongs_to :hacker_news_story, counter_cache: :recommendations_count

  validates :user_id, uniqueness: { scope: :hacker_news_story_id }
end
