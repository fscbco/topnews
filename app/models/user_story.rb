class UserStory < ApplicationRecord
  belongs_to :user
  attr_accessor :story
  after_save :update_story_summary

  def story
    @cached_story ||= TopStory.new(story_id)
  end

  def update_story_summary
    user_stories = UserStory.where(story_id: story_id)

    StorySummary.find_or_create_by(story_id: story_id).update(
      title: story.title,
      url: story.url,
      time: story.time,
      upvotes: user_stories.count,
      cached_data: {
        user_names: user_stories.map(&:user).map { |user| "#{user.first_name} #{user.last_name}" }
      }
    )
  end
end
