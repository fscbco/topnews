class Story < ApplicationRecord
  # We need to get all related stars and the users that starred them
  # We could do a 1 to 1 relationship but since multiple people can star a we need to create a pivot table
  has_many :stars, dependent: :destroy
  has_many :starred_by_users, through: :stars, source: :user

  # Make sure none of the fields are null and that 
  validates :hacker_news_id, presence: true, uniqueness: true
  validates :title, :url, presence: true

end
