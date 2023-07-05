class StoriesController < ApplicationController
    def fetch_stories
        StoryBuilder.call
    end
end
