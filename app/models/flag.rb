class Flag < ApplicationRecord
    belongs_to :user
    belongs_to :flagged_story
end