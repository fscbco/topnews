class StoriesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:star, :unstar]

  def index
    @starred_stories = StarredStory.includes(:user, :story).map(&:story).uniq
    @stories = fetch_stories_from_redis
    @stories = fetch_stories_from_service if @stories.empty?
    add_starred_data_to_stories(@stories)
  end

  def star
    story_id = params[:id]
    story = Story.find_by(id: story_id)

    if story
      if current_user.starred_stories.exists?(story_id: story_id)
        render json: { success: false, message: 'Story already starred' }, status: :unprocessable_entity
      else
        current_user.starred_stories.create!(story_id: story_id)
        render json: { success: true, starred_by: story.starred_by_names, story: story }
      end
    else
      render json: { success: false }, status: :not_found
    end
  end

  def unstar
    story_id = params[:id]
    starred_story = current_user.starred_stories.find_by(story_id: story_id)

    if starred_story
      starred_story.destroy
      story = Story.find_by(id: story_id)
      render json: { success: true, starred_by: story.starred_by_names, story: story }
    else
      render json: { success: false, message: 'Story not starred' }, status: :not_found
    end
  end

  private

  def fetch_stories_from_redis
    stories_json = $redis.lrange(StoryFetcherService::STORY_LIST_KEY, 0, -1)
    stories_json.map { |story| JSON.parse(story, symbolize_names: true) }
  end

  def fetch_stories_from_service
    service = StoryFetcherService.new
    service.perform
  end

  def add_starred_data_to_stories(stories)
    # Get all starred story IDs for the current user
    starred_story_ids = current_user.starred_stories.pluck(:story_id)

    # Mark stories as starred if they are in the user's starred stories
    stories.each do |story|
      story['is_starred'] = starred_story_ids.include?(story['id'].to_s)
    end

    stories
  end
end