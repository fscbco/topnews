module HackerNews
  class CreateItemDetail < Base

    attr_reader :story_id

    def initialize(story_id)
      @story_id = story_id
    end

    def call  
        data = get_story_detail(story_id)
        create_story_detail(data)       
    end


    private

    def get_story_detail(story_id)
      
      url = URI.parse("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json?")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Get.new(url)
      request['Content-Type'] = 'application/json'
      
      http.request(request).body

    end

    def create_story_detail(data)

      data = JSON.parse(data)
      @news_detail = NewsDetail.new(hn_id: data["id"], url: data["url"], 
      author: data["by"], score: data["score"], title: data["title"], 
      story_type: data["type"], comment_count: data["descendants"])

      @news_detail.save!
    end
0

  end
end