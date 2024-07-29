class HackerNews
  include HTTParty
  base_uri 'https://hacker-news.firebaseio.com/v0'

  def top_stories
    response = self.class.get("/topstories.json")
    raise HTTParty::ResponseError, response unless response.success?
    JSON.parse(response.body)
  end

  def item(id)
    response = self.class.get("/item/#{id}.json")
    raise HTTParty::ResponseError, response unless response.success?
    JSON.parse(response.body)
  end
end
