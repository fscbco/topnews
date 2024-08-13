module HackerNews
  class Base
    Result = Struct.new(:success?, :data, :errors)


    def get_new_stories
      url =  URI.parse('https://hacker-news.firebaseio.com/v0/newstories.json')

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Get.new(url)
      request['Content-Type'] = 'application/json'
      
      http.request(request)
      
    end



    def newest_story_id
    
      @_uri ||= begin
         uri = URI('https://hacker-news.firebaseio.com/v0/maxitem.json')
          Net::HTTP.get(uri).gsub(/\s+/, '').to_i
      end
    end
    
  end
end