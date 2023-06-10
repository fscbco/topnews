class Story < ApplicationRecord
  has_many :user_stories
  has_many :starring_users, through: :user_stories, source: :user

end
