# require 'net/http'

class HackerNewsApi
    def self.get_current_stories_ids
        uri = URI("https://hacker-news.firebaseio.com/v0/topstories.json")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)

        handle_response(response)
    end

    def self.get_story_details(story_id)
        return nil if story_id.blank?
        
        uri = URI("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json")
        response = response(uri)

        handle_response(response)
    end

    def self.response(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri)
        http.request(request)
    end

    def self.handle_response(response)
        if response.code == "200"
            data = JSON.parse(response.body)
        else
           puts "API request failed with code #{response.code}"
        end
    end

end