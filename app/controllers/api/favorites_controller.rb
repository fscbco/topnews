module Api
  class FavoritesController < ApplicationController
    before_action :authenticate_user!

    def create
      @favorite = Favorite.new(
        story_id: params[:story_id],
        user_id: current_user.id
      )

      if @favorite.save
        render json: @favorite, status: 201
      else
        render json: @favorite.errors.full_messages, status: 422
      end
    end

    def destroy
      @favorite = Favorite.find_by(user_id: current_user.id, story_id: params[:story_id])

      if @favorite.present?
        @favorite.destroy
        render json: @favorite, status: 204
      else
        render json: { error: "Favorite not found" }, status: 404
      end
    end
  end
end