class FlaggedStory < ApplicationRecord
  belongs_to :user
  belongs_to :story

  scope :distinct_stories, -> { select( "story.id" ).distinct }
end
