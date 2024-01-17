class UserStory < ApplicationRecord
 validates :story, presence: true
 validates :user, presence: true

 belongs_to :user
 belongs_to :story
end
