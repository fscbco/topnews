class PagesController < ApplicationController
    before_action :authenticate_user!
    
    def top_stories
        top_story_ids = top_stories_ids = call_api("https://hacker-news.firebaseio.com/v0/topstories.json")
        @stories = get_stories_from_ids(top_story_ids, 50)
    end
    
    def saved_stories
    end

    def save_story
        if !Story.exists?(api_id: params[:api_id])
            story = get_story_from_id(params[:api_id])
            story.save
        else
            story = Story.find_by(api_id: params[:api_id])
        end
        if !StorySave.exists?(user_id: current_user.id, story_id: story.id, api_id: story.api_id)
            StorySave.create(user_id: current_user.id, story_id: story.id, api_id: story.api_id)
        end
        redirect_to root_path
    end

    def get_stories_from_ids(ids, limit=nil)
        stories = []
        if limit != nil
            ids = ids.take(limit)
        end
        ids.each do |id|
            story = get_story_from_id(id)
            stories.append(story)
        end
        return stories
    end

    def get_story_from_id(id)
        story_json = call_api("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
        story = Story.new(title: story_json["title"], author: story_json["by"], url: story_json["url"], api_id: story_json["id"], object_type: story_json["type"], time_posted: Time.at(story_json["time"]))
        return story
    end
end
