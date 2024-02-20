class HackerRankNews
  include HTTParty
  base_uri "https://hacker-news.firebaseio.com/v0"

  default_options.update(verify: false)

  def get_top_stories
    response = self.class.get("/topstories.json")
    handle_response(response)
  end

  def get_story(id)
    response = self.class.get("/item/#{id}.json")
    handle_response(response)
  end

  private

  def handle_response(response)
    if response.success?
      response
    else
      Rails.logger.error "HackerRankNews API Error: #{response.code}"
      nil
    end
  end
end