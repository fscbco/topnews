class StoriesController < ApplicationController

  def index
    # Rob Note: to avoid creating user_faves and other_faves I debated created a query object
    #           the basis for the object can be found at
    #           https://gist.github.com/dabobert/7470f62d3ab2b704a2213595eb8a07a7
    #           but due to the time constraints and the added complexity
    #           I decided to go with the current implementation
    @user_faves  = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @other_faves = Favorite.where.not(user_id: current_user.id).pluck(:post_id)
    page         = params[:page] || 1
    per_page     = params[:per_page] || 10
    @stories     = Post.includes(:post_author).desc_stories.paginate(page:, per_page:)
  end
end
