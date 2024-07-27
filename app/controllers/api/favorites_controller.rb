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
      @favorite = Favorite.find(params[:id])
      @favorite.destroy
    end
  end
end