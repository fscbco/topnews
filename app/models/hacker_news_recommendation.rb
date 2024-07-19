class HackerNewsRecommendation < ApplicationRecord
  belongs_to :user
  belongs_to :hacker_news_story, counter_cache: :recommendations_count
end
