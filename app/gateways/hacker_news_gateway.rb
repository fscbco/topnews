require "json"

module HackerNewsApi
  extend self

  def top_story_ids
    response = Typhoeus.get("https://hacker-news.firebaseio.com/v0/topstories.json")
    JSON.parse(response.body)
  end

  def fetch_stories(ids)
    requests = requests_for(ids)

    # Queue up each request
    responses = Array.new(ids.size)
    hydra = Typhoeus::Hydra.new(max_concurrency: 10)
    requests.each_with_index do |req, idx|
      req.on_complete do |resp|
        # Maintain order of responses
        responses[idx] = JSON.parse(resp.body) 
      end
      hydra.queue(req)
    end

    # Execute requests in parallel
    hydra.run

    # Array of parsed responses in originally requested order
    responses
  end

  private

  def requests_for(ids)
    ids.map { |id| Typhoeus::Request.new("https://hacker-news.firebaseio.com/v0/item/#{id}.json") }
  end
end

class HackerNewsStory
  attr_accessor :id, :by, :score, :time, :title, :url

  def initialize(id:, by:, score:, time:, title:, url:)
    @id, @by, @score, @time, @title, @url = id, by, score, time, title, url
  end
end

class HackerNewsGateway
  def initialize(api=HackerNewsApi)
    @api = api
  end

  def top_stories(count = 10)
    # Fetch all top story ids, truncate to requested number
    ids = @api.top_story_ids[0...count]
    # Initialize story objects
    @api.fetch_stories(ids).map { |s| initialize_story(s) }
  end

  private

  def initialize_story(hash)
    hash.transform_keys!(&:to_sym)
    args = hash.slice(:by, :id, :score, :title, :url)
    HackerNewsStory.new(time: Time.at(hash[:time]), **args)
  end
end
