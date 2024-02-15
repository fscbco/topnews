class HackerRankNews
  include HTTParty
  base_uri "https://hacker-news.firebaseio.com/v0"

  def get_top_stories
    self.class.get("/topstories.json")
  end

  def get_story(id)
    self.class.get("/item/#{id}.json")
  end
end