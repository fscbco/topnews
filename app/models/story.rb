class Story < ApplicationRecord
  has_many :flagged_stories
  has_many :users, through: :flagged_stories
end
