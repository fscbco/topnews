class HackerNewsClient
  include HTTParty
  base_uri 'https://hacker-news.firebaseio.com'

  def fetch_story_ids
    res = self.class.get("/v0/topstories.json?print=pretty")
    JSON.parse(res.body)[0..10]
  end

  def fetch_story(id)
    res = self.class.get("/v0/item/#{id}.json?print=pretty")
    JSON.parse(res.body)
  end
end
