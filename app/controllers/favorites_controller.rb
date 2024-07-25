class FavoritesController < ApplicationController
    before_action :restrict_access
    
    def create
        Favorite.find_or_create_by!(story_id: params[:story_id], user_id: current_user.id)
        redirect_to root_path
    end

    def destroy
        Favorite.find_by(story_id: params[:story_id], user_id: current_user&.id)&.destroy
        redirect_to root_path
    end

    private

    def restrict_access
        redirect_to new_user_session_path unless current_user
    end
end

