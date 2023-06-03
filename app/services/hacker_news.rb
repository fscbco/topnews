require "http"

class HackerNews
  TOP_STORIES_URL = "https://hacker-news.firebaseio.com/v0/topstories.json"
  STORY_DETAILS_URL = "https://hacker-news.firebaseio.com/v0/item/"
  TOP_STORIES_FETCH_LIMIT = 100
  
  # over time, we will have many old news stories
  # as an improvement, we could check the posted_at timestamp and
  # delete any stories not starred/ posted more than 1 week ago 
  def self.fetch_and_save_to_stories
    story_ids = get_top_story_ids.first(TOP_STORIES_FETCH_LIMIT)

    return if !story_ids

    story_ids.each do |story_id|
      # update all stories (in case URL or other relevant data has changed)
      story = Story.find_or_initialize_by(reference_id: story_id)
      story_details = get_story_details(story_id)
      if story_details
        story.title = story_details["title"]
        story.url = story_details["url"]
        story.posted_at = Time.at(story_details["time"]).utc
        story.author = story_details["by"]
        story.save
      end
    end
  end

  def self.get_top_story_ids
    response = HTTP.get(TOP_STORIES_URL)
    if response.status.success?
      JSON.parse(response.body)
    else
      Rails.logger.error("Error getting top story ids - status: #{response.status}, body: #{response.body}")
      return
    end
  end

  def self.get_story_details(story_id)
    response = HTTP.get(STORY_DETAILS_URL + "#{story_id}" + ".json")
    if response.status.success?
      JSON.parse(response.body)
    else
      Rails.logger.error("Error getting top story details - status: #{response.status}, body: #{response.body}")
      return
    end
  end
end
