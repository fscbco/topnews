class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stories
  has_many :starred_stories, through: :user_stories, source: :story

  # The many-to-many relationship between users and stories is not necessary for these project requiremments,
  # but in the spirit of building for the long run, I chose to use this association for a feature that will allow clients to select users and see a list of the
  # stories they've starred.
end

