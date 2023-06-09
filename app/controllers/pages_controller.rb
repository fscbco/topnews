class PagesController < ApplicationController
    before_action :authenticate_user!
    
    def top_stories
        top_story_ids = top_stories_ids = call_api("https://hacker-news.firebaseio.com/v0/topstories.json")
        @stories = get_stories_for_ids(top_story_ids, 50)
    end
    
    def saved_stories
    end

    def get_stories_for_ids(ids, limit=nil)
        stories = []
        if limit != nil
            ids = ids.take(limit)
        end
        ids.each do |id|
            story_json = call_api("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
            story = Story.new(title: story_json["title"], author: story_json["by"], url: story_json["url"], api_id: story_json["id"], object_type: story_json["type"], time_posted: Time.at(story_json["time"]))
            stories.append(story)
        end
        return stories
    end
end
