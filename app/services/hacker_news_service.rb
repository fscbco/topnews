class HackerNewsService
  def self.get_top_10_story_ids
    uri = URI('https://hacker-news.firebaseio.com/v0/topstories.json')
    
    begin
      response = Net::HTTP.get_response(uri)
    rescue StandardError
      false
    end
    
    JSON.parse(response.body)[0..9]
  end

  def self.get_story_details(id)
    uri = URI("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
    
    begin
      response = Net::HTTP.get_response(uri)
    rescue StandardError
      false
    end
    
    JSON.parse(response.body)
  end
end
