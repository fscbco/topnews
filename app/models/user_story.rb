class UserStory < ApplicationRecord
  belongs_to :user
  belongs_to :story

  validates :user_id, :presence, uniqueness: { scope: :story_id }
  validates :story_id, :presence, uniqueness: { scope: :user_id }
end
