class StorySummary < ApplicationRecord
  attr_accessor :story

  def story
    @cached_story ||= TopStory.new(story_id)
  end
end
