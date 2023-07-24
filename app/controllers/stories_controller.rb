class StoriesController < ApplicationController
  HACKER_NEWS_GET_STORY_URL = "https://hacker-news.firebaseio.com/v0/item/".freeze
  HACKER_NEWS_TOP_STORIES_URL = "https://hacker-news.firebaseio.com/v0/topstories.json".freeze

  def home
    story_ids = call_api(HACKER_NEWS_TOP_STORIES_URL)

    # TODO: add a caching mechanism here for efficiency if time permits
    non_persisted_stories = story_ids.map(&:to_s) - Story.where(story_id: story_ids).pluck(:story_id)

    # Continuously adds 10 of the non_persisted_stories to the database
    # TODO: pagination would make sense here
    non_persisted_stories.first(10).each { |story_id| create_story(story_id) }

    @stories = Story.includes(starrables: :user).where(story_id: story_ids)

  # Net::HTTP can return a LOT of different types of errors
  rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
    Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => _e

    flash[:alert] = "There was an error retrieving stories from Hacker News. Please try again later"

    @stories = Story.includes(starrables: :user)
  rescue ActiveRecord::RecordInvalid => error

    flash[:alert] = error.message

    @stories = Story.includes(starrables: :user)
  ensure
    @current_user_stories = []
    @current_user_stories = @stories.joins(:starrables).where(starrables: {user_id: current_user.id}) if @stories
  end

  def starred
    @starred_stories = Story.joins(:starrables).distinct
  end

  private

  def story_url(story_id)
    "#{HACKER_NEWS_GET_STORY_URL}#{story_id}.json"
  end

  def create_story(story_id)
    story_url_string = story_url(story_id)
    story_response = call_api(story_url_string)
    params = create_story_params(story_response)
    Story.create!(params)
  end

  def create_story_params(res)
    params = res.slice("by", "id", "score", "time", "title", "url")
    params["author"] = params.delete("by")
    params["story_id"] = params.delete("id")
    params["time"] = Time.at(params.delete("time")).to_datetime
    params
  end

  def call_api(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
