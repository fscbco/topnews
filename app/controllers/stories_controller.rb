class StoriesController < ApplicationController

    def index
        @limit = 25
        @stories = HackerNews.get_list_of_top_stories_api().first(@limit)
    end

    def starred
        @stories = Story.select('stories.*, COUNT(stories.id) AS star_count')
                            .joins(:stars)
                            .group('stories.id')
                            .order('star_count DESC')
                          
    end

end
