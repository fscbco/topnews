require 'open-uri'

class PagesFetch

  def list
    body = URI.parse(top_stories_url_string).read
    JSON(body).first(10)
  end

  def get(id)
    body = URI.parse(item_url_string(id)).read
    JSON(body)
  end

  def top_stories_url_string
    'https://hacker-news.firebaseio.com/v0/topstories.json'
  end

  def item_url_string(id)
    "https://hacker-news.firebaseio.com/v0/item/#{id}.json"
  end
end
