class FavoritesController < ApplicationController

  def index
    @stories = current_user.favorited_posts.paginate(page:, per_page:)
  end
end
