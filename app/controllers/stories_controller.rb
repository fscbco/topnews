class StoriesController < ApplicationController

    def index
        @stories = HackerNews.get_list_of_top_stories_api().first(25)
    end

    def starred
        @stories = Story.select('stories.*, COUNT(stories.id) AS star_count')
                            .joins(:stars)
                            .group('stories.id')
                            .order('star_count DESC')
                          
    end


end