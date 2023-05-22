class FlaggedStory < ApplicationRecord
  has_many :picks
  has_many :users, through: :picks

  validate :title
  validate :url
end
