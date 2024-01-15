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
