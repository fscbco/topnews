class StoriesController < ApplicationController
  def top
    stories = Story.top(20)
    decorated_stories = stories.map do |story|
      StoryDecorator.new(user: current_user, story:)
    end

    @stories = decorated_stories
  end

  def starred
    stories = Story.starred
    decorated_stories = stories.map do |story|
      StoryDecorator.new(user: current_user, story:)
    end

    @stories = decorated_stories
  end

  def star
    current_user.story_stars.find_or_create_by(story_id: params[:id])

    redirect_back(fallback_location: root_path)
  end

  def unstar
    current_user.story_stars.destroy_by(story_id: params[:id])

    redirect_back(fallback_location: root_path)
  end
end
