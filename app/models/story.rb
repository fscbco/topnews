class Story < ApplicationRecord
    has_many :story_saves, dependent: :destroy
    has_many :users, through: :story_saves
    validates :api_id, uniqueness: true
end
