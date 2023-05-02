class Story < ApplicationRecord

    has_many :stars
    has_many :users, through: :stars

    validates :hn_story_id, presence: true, uniqueness: true
    
end