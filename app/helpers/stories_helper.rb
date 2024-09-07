module StoriesHelper
  def story_in_database?(story_id)
    Story.exists?(hacker_news_id: story_id)
  end

  def story_starred_by_users(story_id)
    Story.find_by(hacker_news_id: story_id)&.starred_by_users
  end
end