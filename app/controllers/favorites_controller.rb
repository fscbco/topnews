class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    @favorite = Favorite.create!(post_id: favorite_params['post_id'], user: current_user)

    redirect_to root_path
  rescue StandardError => e
    # Generic, placeholder for more specific error handling.
    Rails.logger.error("Failed to create favorite #{e}")
  end

  def favorite_params
    params.permit(:post_id)
  end
end
