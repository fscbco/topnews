class FlaggedStory < ApplicationRecord
  belongs_to :user

  scope :distinct_stories, -> { select( "story.id" ).distinct }
end
