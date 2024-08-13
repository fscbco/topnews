class HackerNewsScraper
  API_ROOT = "https://hacker-news.firebaseio.com/v0/"

  def self.retrieve_top_stories(
    limit: nil,
    cache_expiry: 3.minutes,
    relevant_fields: []
  )
    Rails.cache.fetch(
      :hacker_news_top_stories,
      expires_in: cache_expiry
    ) do
      scraper = new
      story_ids = scraper.fetch_top_story_ids
      limit ||= story_ids.size

      scraper
        .fetch_stories(story_ids.first(limit))
        .map do |story_details|
          story_details.slice(*relevant_fields)
        end
    end
  end

  def self.retrieve_story_details(
    story_id:,
    cache_expiry: 1.day,
    relevant_fields: []
  )
    Rails.cache.fetch(
      [:story_details, story_id],
      expires_in: cache_expiry
    ) do
      story_details = new.fetch_story_details(story_id)
      story_details.slice(*relevant_fields)
    end
  end

  def fetch_top_story_ids
    end_point = "topstories.json"
    get(end_point)
  end

  def fetch_story_details(story_id)
    end_point = story_endpoint(story_id)
    get(end_point)
      .symbolize_keys
  end

  def fetch_stories(story_ids)
    hydra = Typhoeus::Hydra.new
    requests = build_hydra_requests(story_ids) do |request|
      hydra.queue(request)
    end
    hydra.run

    requests.map do |request|
      JSON.parse(request.response.body)
        .symbolize_keys
    end
  end

  private

  def get(api_endpoint)
    request = Typhoeus.get(API_ROOT + api_endpoint)
    JSON.parse(request.response_body)
  end

  def story_endpoint(story_id)
    "item/#{story_id}.json"
  end

  def build_hydra_requests(story_ids, &block)
    story_ids.map do |story_id|
      api_end_point = API_ROOT + story_endpoint(story_id)
      Typhoeus::Request.new(api_end_point)
        .tap { |req| block.call(req) }
    end
  end
end
