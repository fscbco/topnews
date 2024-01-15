class Like < ApplicationRecord
  belongs_to :hacker_news_story
  belongs_to :user
end
