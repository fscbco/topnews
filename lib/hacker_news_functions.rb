module HackerNewsFunctions
    def get_hacker_news(endpoint)
        url = "https://hacker-news.firebaseio.com/v0/#{endpoint}.json"
        uri = URI.parse(url)
        
        res = Net::HTTP.get_response(uri)
        return JSON.parse(res.body)
    end

    def get_top_story_ids
        get_hacker_news('topstories')
    end
end