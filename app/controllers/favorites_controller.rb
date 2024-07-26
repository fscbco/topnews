class FavoritesController < ApplicationController

  def create
    # finding to verify it exists
    post = Post.find(params[:post_id])
    Favorite.create(user: current_user, post:)
  rescue StandardError => e
    flash[:alert] = e.message
  ensure
    redirect_back(fallback_location: root_path)
  end

  def index
    @user        = User.find(params[:user_id])
    @user_faves  = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @other_faves = Favorite.where.not(user_id: current_user.id).pluck(:post_id)
    @stories     = @user.favorited_posts.paginate(page:, per_page:)
  end
end
