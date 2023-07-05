require 'hacker_news_functions'
class StoryBuilder < ApplicationService
    include HackerNewsFunctions

    def call
        get_top_story_ids.each do |story_id|
            unless story_exists?(story_id)
                res = get_item_resource(story_id)
                create_story(res)
            end
        end
    end

private
    def story_exists?(story_id)
        Story.exists?(story_id: story_id)
    end

    def create_story(response)
        Story.create(
                    author: response['by'],
                    story_id: response['id'],
                    time: Time.at(response['time']).to_datetime,
                    title: response['title'],
                    url: response['url']
                )
    end
end