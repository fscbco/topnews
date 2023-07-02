require 'hacker_news_functions'
class StoryBuilder < ApplicationService
    include HackerNewsFunctions

    def call
        story_ids = get_top_story_ids
        
        story_ids.each do |story_id|
            unless Story.exists?(story_id: story_id)
                res = get_item_resource(story_id)
                
                Story.create(
                    author: res['by'],
                    story_id: story_id,
                    time: Time.at(res['time']).to_datetime,
                    title: res['title'],
                    url: res['url']
                )
            end
        end
    end
end