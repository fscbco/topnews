class PagesController < ApplicationController
    def home
        top_story_ids = TopStory.latest.external_ids.first(10)
        stories = Story.from_hacker_news.where(external_id: top_story_ids)
        order = top_story_ids.each_with_index.to_h
        @hacker_news_stories = stories.sort_by{ |story| order[story.external_id] }
    end
end
