class HackerNewsApi
  def self.get_top_story_ids
    JSON.parse(HTTParty.get("https://hacker-news.firebaseio.com/v0/topstories.json").body)
  end

  def self.get_story(id)
    JSON.parse(HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json").body)
  end
end
