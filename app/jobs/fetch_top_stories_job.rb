class FetchTopStoriesJob < ApplicationJob
  queue_as :default

  TOP_STORIES_URL = "https://hacker-news.firebaseio.com/v0/topstories.json"
  STORY_DETAILS_URL = "https://hacker-news.firebaseio.com/v0/item/%d.json"

  def perform
    response = HTTP.get(TOP_STORIES_URL)
    return unless response.status.success?

    top_story_ids = JSON.parse(response.body.to_s)
    top_story_ids.first(10).each do |story_id|
      fetch_and_save_story(story_id)
    end
  end

  private

  def fetch_and_save_story(story_id)
    story_url = format(STORY_DETAILS_URL, story_id)
    response = HTTP.get(story_url)

    return unless response.status.success?

    story_data = JSON.parse(response.body.to_s)
    story = Story.find_or_initialize_by(hn_id: story_id)
    story.title = story_data["title"]
    story.url = story_data["url"]
    story.save
  end
end
