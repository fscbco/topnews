class Story < ApplicationRecord
 validates :title, presence: true, uniqueness: true
 validates :url, presence: true, uniqueness: true

 has_many :user_stories
end
