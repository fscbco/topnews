class FlaggedStory < ApplicationRecord
  belongs_to :user, foreign_key: 'users_id'
  belongs_to :story, foreign_key: 'stories_id'
end
