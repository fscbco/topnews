class PagesController < ApplicationController
    def home
        external_story_ids = TopStory.latest_external_ids_from_hacker_news_cache.first(10)
        stories = Story.includes(:users).from_hacker_news.where(external_id: external_story_ids)
        order = external_story_ids.each_with_index.to_h
        @hacker_news_stories = stories.sort_by{ |story| order[story.external_id] }

        return unless current_user

        @user_stories = current_user.stories.from_hacker_news.includes(:users) 
        @saved_stories = Story.from_hacker_news.joins(:user_stories).includes(:users)
    end
end
