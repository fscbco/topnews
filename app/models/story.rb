class Story < ApplicationRecord
    has_many :story_saves, dependent: :destroy, class_name: "StorySave"
    has_many :users, through: :story_saves
    validates :api_id, uniqueness: true
end
