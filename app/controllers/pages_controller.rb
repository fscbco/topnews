class PagesController < ApplicationController

    def home
        @stories = Story.all.order(story_id: :desc).limit(100)
    end
end
