class ApiClient
  BASE_URL = "https://hacker-news.firebaseio.com"

  def initialize
    @connection = Faraday.new(url: BASE_URL) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.headers[''] = ''
    end
  end

  def top_item_ids
    response = @connection.get '/v0/topstories.json'
    JSON.parse response.body
  end

  def top_stories(limit=30)
    top_item_ids[0..limit].map{|item_id| get_story(item_id)}.compact
  end

  def get_story(story_id)
    response = @connection.get "/v0/item/#{story_id}.json"
    Struct.new("Item", :hacker_news_id, :url, :title, :type, :liked)
    
    parsed_response = JSON.parse response.body

    if parsed_response
      Struct::Item.new(parsed_response['id'], parsed_response['url'], parsed_response['title'], parsed_response['type'], false)  
    end
    
  end

end