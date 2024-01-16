class Story < ApplicationRecord
 validates :title, presence: true
 validates :url, presence: true
 has_many :user_story
end
