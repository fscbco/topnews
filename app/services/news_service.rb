class NewsService
  def self.fetch_stories
    # check cache first
    #story_ids = HackerNewsClient.new.fetch_story_ids
    Story.all
  end

  def self.fetch_story(story_id:)
    HackerNewsClient.new.fetch_story(story_id)
  end

  def self.fetch_user_stories
    user_stories = UserStories.all.order(id: :desc)
  end

  def self.create_new_like(story_id:, user_id:)
    UserStories.create(
      story: Story.find(story_id),
      user: User.find(user_id)
    )
  end
end
