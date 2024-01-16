class UserStories < ApplicationRecord
 validates :story, presence: true
 validates :user, presence: true
 has_one :user
 has_one :story
end
