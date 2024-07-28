module Api
  class FavoritedStoriesController < ApplicationController
    before_action :authenticate_user!

    def index
      @favorited_stories = Story.
        joins(:favorites).
        group("stories.id").
        select("stories.*, COUNT(favorites.id) as favorites_count").
        order("favorites_count DESC")

      render json: @favorited_stories
    end
  end
end