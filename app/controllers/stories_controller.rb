# frozen_string_literal: true

# StoriesController handles actions related to stories, including listing and liking stories.
class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_stories

  # Lists stories, sorted by newest first.
  #
  # @return [void]
  def index
    @stories = Story.newest_first
  end

  # Handles liking a story.
  #
  # If the current user has not already liked the story, it creates a like and updates the page.
  #
  # @return [void]
  def like
    story = Story.find(params[:id])
    return if already_liked?(story)

    Like.create(user: current_user, story:)

    respond_to do |format|
      format.html { redirect_to stories_path }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "like_#{story.hacker_news_id}",
          partial: 'likes',
          locals: { story: }
        )
      end
    end
  end

  private

  # Loads stories from the Hacker News API.
  #
  # @return [void]
  def load_stories
    HackerNewsApi.new.fetch_stories
  end

  # Checks if the current user has already liked the given story.
  #
  # @param story [Story] The story to check.
  # @return [Boolean] True if the current user has already liked the story, false otherwise.
  def already_liked?(story)
    Like.where(user_id: current_user.id, story_id: story.id).exists?
  end
end
