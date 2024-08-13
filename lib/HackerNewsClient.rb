class HackerNewsClient
  BASE_URL = 'https://hacker-news.firebaseio.com/v0/'

  def self.get_top_story_ids(limit=100)
    response = Net::HTTP.get_response(URI(BASE_URL + 'topstories.json'))
    JSON.parse(response.body)[0..limit-1]
  end

  def self.get_story(story_id)
    response = Net::HTTP.get_response(URI(BASE_URL + "item/#{story_id}.json"))
    JSON.parse(response.body)
  end

  def self.get_top_stories(limit=100)
    stories = []

    self.get_top_story_ids[0..limit-1].each do |story_id, ix|
      stories.append(self.get_story(story_id))
    end

    stories
  end
end