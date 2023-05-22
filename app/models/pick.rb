class Pick < ApplicationRecord
  belongs_to :user
  belongs_to :flagged_story
end
