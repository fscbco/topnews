class ImportTopStories
  class << self
    def call
      new.call
    end
  end

  def call
    story_ids = GetTopStories.call

    story_ids.each do |story_id|
      ImportStory.call(story_id)
    end
  end
end