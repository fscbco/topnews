class PagesController < ApplicationController
    def home
        @logged_in = current_user.present?
        @stories_data = StoryService.get_stories_data(current_user)
    end

    def interesting_stories
        @logged_in = current_user.present?
        @stories_data = StoryService.get_interesting_stories(current_user)
        render :home
    end
end

