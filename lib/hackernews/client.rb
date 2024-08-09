module Hackernews
  class Client
    def initialize
      @host = 'yc-hacker-news-official.p.rapidapi.com'
      @key = '47c077067cmsh8cf0f42903b81f2p17d893jsnfdf4cc518214'
    end
    def item(id)
      get("item/#{id}")
    end
    def topstories(start = 0, per_page = 10, expand = true)
      stories = get('topstories')[start...start + per_page]
      if expand
        stories.map! do |story|
          item(story)
        end
      end
      stories
    end
    private
    def get(path)
      response = Excon.get(
        'https://' + @host + '/' + path + '.json?print=pretty',
        headers: {
          'x-rapidapi-host' => @host,
          'x-rapidapi-key' => @key,
        }
      )
      return false if response.status != 200
      JSON.parse(response.body)
    end
  end
end
