class FavoritesController < ApplicationController
  def new
    @favorite = Favorite.new
  end
  
  def create
    @favorite = current_user.favorites.build(favorite_params)
    if @favorite.save
        redirect_to "/"
    end
  end
  
  private

  def favorite_params
    params.permit(:story_id)
  end
end
