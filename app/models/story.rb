class Story < ApplicationRecord
  has_many :flagged_stories, foreign_key: 'stories_id'
  has_many :users, through: :flagged_stories
end
