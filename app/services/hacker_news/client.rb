module HackerNews
  class Client < HttpClient
    def initialize
      super
    end

    def base_url
      "https://hacker-news.firebaseio.com/v0/"
    end

    def top_stories
      get("topstories.json")
    end

    def item(id)
      get("item/#{id}.json")
    end

    def handle_response(response)
      JSON.parse(response.body, symbolize_names: true)
    rescue => e
      Rails.logger.error(e)
    end
  end
end
