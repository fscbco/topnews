class PagesController < ApplicationController
    before_action :set_stories
    def home
    end

private
    def set_stories
        
        if params['filter'].present?
            @stories = Story.joins(:stars).includes(:stars, :users)
            return
        end
        @stories = Story.all.order(story_id: :desc).limit(100)
    end
end
