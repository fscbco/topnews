class ImportStory
  class << self
    def call(story_id)
      new(story_id).call
    end
  end

  def initialize(story_id)
    @story_id = story_id
  end

  def call
    unless Story.exists?(story_id: @story_id)
      story = GetStory.call(@story_id)

      Story.create!(
        story_id: story['id'],
        title: story['title'],
        url: story['url'],
        by: story['by'],
        time: Time.at(story['time']),
        text: story['text']
      )
    end
  end
end