class Story < ApplicationRecord
  validates_presence_of :story_id
  validates_uniqueness_of :story_id
end
