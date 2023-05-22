class FlaggedStory < ApplicationRecord
  has_many :users, through: :pick

  validate :title
  validate :url
end
