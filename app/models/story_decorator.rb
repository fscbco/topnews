class StoryDecorator < SimpleDelegator
  include Rails.application.routes.url_helpers

  attr_reader :user

  def initialize(user:, story:)
    @user = user
    super(story)
  end

  def formatted_created_at
    created_at.strftime("%a %b %d, %Y")
  end

  def starred?
    starred_by?(user)
  end

  def toggle_star_path
    starred? ? unstar_story_path(id) : star_story_path(id)
  end

  def star_color
    starred? ? "rgb(250 204 21)" : "rgb(156 163 175)"
  end
end
