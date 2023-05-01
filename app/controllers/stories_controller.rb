class StoriesController < ApplicationController

    def index
        @stories = HackerNews.new.get_list_of_top_stories_api().first(25)
    end

    def show
        @stories = HackerNews.new.get_list_of_top_stories_api()
    end


end