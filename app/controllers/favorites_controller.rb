class FavoritesController < ApplicationController
    def create
        Favorite.find_or_create_by!(story_id: params[:story_id], user_id: current_user.id)
        redirect_to root_path
    end

    def destroy
        Favorite.find_by(story_id: params[:story_id], user_id: current_user.id)&.destroy
        redirect_to root_path
    end
end

