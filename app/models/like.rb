class Like < ApplicationRecord
  belongs_to :user
  belongs_to :story
  validates :user_id, uniqueness: { scope: :story_id }


end
