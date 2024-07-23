# app/models/interesting_story.rb
class InterestingStory < ApplicationRecord
  belongs_to :user
  belongs_to :story
  validates :user_id, uniqueness: { scope: :story_id, message: "has already marked this story as interesting" }
end