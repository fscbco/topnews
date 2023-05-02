require 'net/http'
require 'json'

class HackerNews
    
    def self.get_list_of_top_stories_api
        uri = URI("https://hacker-news.firebaseio.com/v0/topstories.json")
        response = JSON.parse(Net::HTTP.get(uri))
        response.map {|hn_story_id| get_story_record(hn_story_id)}
    end

    def self.get_story_api(hn_story_id)
        uri = URI("https://hacker-news.firebaseio.com/v0/item/#{hn_story_id}.json")
        JSON.parse(Net::HTTP.get(uri))
    end

    def self.get_story_record(hn_story_id)
        record = Story.find_by(hn_story_id: hn_story_id)
        if record
            return record
        else
            story = get_story_api(hn_story_id)
            url = "https://news.ycombinator.com/item?id=#{hn_story_id}"
            Story.create(hn_story_id: hn_story_id, title: story["title"], by: story["by"], time: story["datetime"], url: url)
        end
    end
end