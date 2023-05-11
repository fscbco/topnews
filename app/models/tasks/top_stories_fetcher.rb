require 'net/http'
require 'json'

class TopStoriesFetcher
  BASE_URL = 'https://hacker-news.firebaseio.com/v0'

  def self.fetch_and_save(limit = 30)
  	@limit = limit
    story_ids = fetch_top_story_ids
    existing_story_ids = Story.where(story_id: story_ids).pluck(:story_id)
    new_story_ids = story_ids - existing_story_ids
    new_story_details = fetch_story_details(new_story_ids)
    save_stories(new_story_details)
  end

  private

  def self.fetch_top_story_ids
    url = "#{BASE_URL}/topstories.json"
    response = Net::HTTP.get_response(URI(url))
    JSON.parse(response.body).first(@limit)
  end

  def self.fetch_story_details(story_ids)
    story_ids.map do |story_id|
      url = "#{BASE_URL}/item/#{story_id}.json"
      response = Net::HTTP.get_response(URI(url))
      JSON.parse(response.body)
    end
  end

  def self.save_stories(story_details)
    story_details.each do |details|
      story = Story.find_or_initialize_by(story_id: details['id'])
      story.title = details['title']
      story.url = details['url'] || "https://news.ycombinator.com/item?id=#{details['id']}"
      story.author = details['by']
      story.score = details['score']
      story.story_time = Time.at(details['time'])
      story.save!
    end
  end
end
