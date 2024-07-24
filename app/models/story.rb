class Story < ApplicationRecord
    has_many :favorites, dependent: :destroy
    has_many :users, through: :favorites

    validates :external_story_id, :title, :url, :by, :time, presence: true
end