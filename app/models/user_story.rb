class UserStory < ApplicationRecord
  belongs_to :user
  belongs_to :story

  validates :user, :story, presence: true

  validates :user, uniqueness: { scope: :story }
end
