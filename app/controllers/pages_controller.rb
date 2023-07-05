class PagesController < ApplicationController
    before_action :set_stories
    def home
    end

private
    def set_stories
        if params['filter'].present?
            @stories = Story.joins(:stars).order(story_id: :desc).limit(100).includes(:stars, :users)
            return
        end
        @stories = Story.order(story_id: :desc).includes(:stars, :users)
    end
end
