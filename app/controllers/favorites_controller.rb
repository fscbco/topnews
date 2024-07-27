class FavoritesController < ApplicationController

  def create
    # finding to verify it exists, so we don't add in garbage data
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

  def all
    # Rob Note: By using includes over a join, we can both avoid the N+1 query problem
    #           and avoid duplicates in the result set.
    @stories = Post.includes(:post_author, favorites: :user)
                   .where.not(favorites: { id: nil })
                   .paginate(page:, per_page:)
  end
end
