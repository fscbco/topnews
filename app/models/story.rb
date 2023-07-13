class Story < ApplicationRecord
  has_many :starred_stories, dependent: :destroy
  has_many :users, through: :starred_stories
end
