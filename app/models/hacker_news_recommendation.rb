class HackerNewsRecommendation < ApplicationRecord
  belongs_to :user
  belongs_to :hacker_news_story
end
