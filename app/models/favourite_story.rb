class FavouriteStory < ApplicationRecord
  belongs_to :story
  belongs_to :user

  validates :story_id, uniqueness: { scope: %i[user_id] }

  
end
