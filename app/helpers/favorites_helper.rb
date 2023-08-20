module FavoritesHelper
  # These helpers and their use in the view query the Favorite table possibly more than necessary,
  # but didn't optimize given it's an internal application.

  def has_favorited?(post_id)
    Favorite.find_by(post_id: post_id, user: current_user)
  end

  def favorited_by(post_id)
    favorites = Favorite.where(post_id: post_id)

    user_list = favorites.map do |favorite|
      user = favorite.user
      "#{user.first_name} #{user.last_name}"
    end

    user_list.join(', ')
  end
end
