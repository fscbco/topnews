# require 'net/http'

class PagesController < ApplicationController
    def home

        # api call for news list
        # looped api call for each story?
        @logged_in = current_user.present?
        @stories = StoriesService.get_stories_data
    end
end

