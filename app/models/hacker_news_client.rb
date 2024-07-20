require 'httparty'

class HackerNewsClient
  include HTTParty
  base_uri 'https://hacker-news.firebaseio.com/v0'

  def top_story_ids
    self.class.get('/topstories.json?print=pretty')
  end

  def fetch_item(id)
    self.class.get("/item/#{id}.json?print=pretty")
  end
end
