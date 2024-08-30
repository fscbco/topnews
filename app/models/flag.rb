class Flag < ApplicationRecord
  belongs_to :user
  
  validates :story_id, presence: true
  validates :user_id, presence: true
  validates :story_id, uniqueness: { scope: :user_id, message: "has already been flagged by this user" }

  def Flag.stories_flagged()
    flags = Flag.includes(:user).group_by(&:story_id)
    return flags
  end
end
