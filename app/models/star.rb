class Star < ApplicationRecord
  belongs_to :user
  belongs_to :story

  # Callback to clean up story if it's no longer starred by any users
  after_destroy :remove_story_if_unstarred

  private

  def remove_story_if_unstarred
    # Destroy the story if no stars remain
    story.destroy if story.stars.empty?
  end
end
