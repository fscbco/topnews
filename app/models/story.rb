class Story < ApplicationRecord
  has_many :starred_stories
  has_many :users, through: :starred_stories
end
