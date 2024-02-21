# frozen_string_literal: true

module FeedHelper
  def details(id:)
    FindOrCreateStoryService.new(id: id).call
  end

  def story_likes(story:)
    story.likes.map { |f| [f.user.first_name, f.user.last_name].join(" ") }.join(", ")
  end
end
