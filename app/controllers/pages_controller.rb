class PagesController < ApplicationController
    def index
        @latest_feed = Feed.last || Feed.fetch_and_persist
        if @latest_feed.created_at < Time.now - 15.minutes
            @latest_feed = Feed.fetch_and_persist
        end

        @flagged_stories = FlaggedStory.includes(:users).all.order(created_at: :desc)
    end
end
