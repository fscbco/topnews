require 'net/http'

class PagesController < ApplicationController
    def home

        # api call for news list
        # looped api call for each story?
        @logged_in = current_user.present?
        ids = get_top_stories_id.first(20)
        @stories = ids.map { |id| get_story_details(id) }
    end

    def get_top_stories_id
        uri = URI("https://hacker-news.firebaseio.com/v0/topstories.json")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)

        if response.code == "200"
            data = JSON.parse(response.body)
        else
           puts "API request failed with code #{response.code}"
        end
    end

    def get_story_details(story_id)
        return nil if story_id.blank?

        # find or create by this story id
        # return a story object, with if you liked it and if others liked it.
        
        uri = URI("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)

        if response.code == "200"
            data = JSON.parse(response.body)
        else
           puts "API request failed with code #{response.code}"
        end
    end

end

