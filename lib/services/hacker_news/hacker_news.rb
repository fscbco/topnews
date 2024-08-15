# require 'uri'
# require 'net/http'

class HackerNews
  API_BASE = 'https://hacker-news.firebaseio.com/v0/'
  TOP_STORIES = 'topstories.json'
  ITEM = 'item/%s.json'

  def topstories()
    url = API_BASE + TOP_STORIES
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    return JSON.parse(response.body) if response.code == '200'
  end

  def item(id)
    item_url = ITEM % id
    url = API_BASE + item_url
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    return HashWithIndifferentAccess.new(JSON.parse(response.body)) if response.code == '200'
  end
end
