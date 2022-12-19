class NewsClient
    def initialize(http = HTTParty)
        @http = http
    end

    def ids
      http.get('https://hacker-news.firebaseio.com/v0/topstories.json')
    end
  
    def item(id)
      http.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
    end

    private
    attr_reader :http
end