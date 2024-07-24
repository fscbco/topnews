class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :story

    validates :user_id, :story_id, presence: true
end