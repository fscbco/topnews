class UserStory < ApplicationRecord
  belongs_to :user
  belongs_to :story

  validates :user_id, uniqueness: { scope: :story_id }
  validates :story_id, uniqueness: { scope: :user_id }
end
