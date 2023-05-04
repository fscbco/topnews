require 'httpparty'

class TopStory
  include HTTParty
  attr_accessor :id, :raw_data

  def self.all
    # Fetch the top stories from the Hacker News API
    response = HTTParty.get("https://hacker-news.firebaseio.com/v0/topstories.json")
    # Parse the response body to JSON
    response_body = JSON.parse(response.body)[0..10]
    # instantiate a new TopStory object for each id in the response body
    response_body.map do |id|
      new(id)
    end
  end
  
  def initialize(id)
    @id = id
  end

  def raw_data
    @cached_raw_data ||= JSON.parse(HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json").body)
  end

  def title
    raw_data["title"]
  end

  def url
    raw_data["url"]
  end

  def time
    raw_data["time"]
  end
end