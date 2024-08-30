module ApplicationHelper
  @@hacker_base= 'https://hacker-news.firebaseio.com/v0/'

  def fetch_top_stories
    response = HTTParty.get("#{@@hacker_base}topstories.json")
    JSON.parse(response.body)
  end

  def fetch_story_details(story_ids)
    details = story_ids.map do |id|
      response = HTTParty.get("#{@@hacker_base}item/#{id}.json")
      JSON.parse(response.body)
    end

    details.compact
  end
end
