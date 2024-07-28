module Api
  class StoriesController < ApplicationController
    def index
      @stories = Story.
        joins(
          ApplicationRecord.sanitize_sql_array([
            "LEFT OUTER JOIN favorites on favorites.story_id = stories.id and favorites.user_id = ?",
            current_user.id
          ])
        ).
        select("stories.*, CASE WHEN favorites.user_id IS NOT NULL THEN true ELSE false END AS is_favorited")

      render json: @stories
    end
  end
end