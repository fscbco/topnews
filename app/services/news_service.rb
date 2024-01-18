class NewsService
  def self.fetch_stories
    if need_refresh?
      insert_latest_stories
    end
      Story.order(created_at: :desc).limit(10)
  end

  def self.fetch_story(story_id:)
    HackerNewsClient.new.fetch_story(story_id)
  end

  def self.fetch_user_stories
    Story.joins(:user_stories).order(id: :desc)
  end

  def self.create_new_like(story_id:, user_id:)
    story = Story.find(story_id)
    user = User.find(user_id)
    UserStory.create(
      story: story,
      user: user
    )
  end
end

private

def need_refresh?
  Story.last&.created_at&.to_date != Time.now.utc.to_date
end

def insert_latest_stories
  story_ids = HackerNewsClient.new.fetch_story_ids
  story_ids.each do |story_id|
    story = self.fetch_story(story_id: story_id)
    Story.find_or_initialize_by(title: story['title'] ).update({
      url: story['url']
    })
  end
end
