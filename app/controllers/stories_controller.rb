class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stories = fetch_stories_from_redis
    @stories.empty? ? fetch_stories_from_service : @stories
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
end
