class PagesController < ApplicationController
  before_action :authenticate_user!

  MAX_STORIES = 20

  def home
    home_page_data = HomePageCollator.call(limit: MAX_STORIES)
    render locals: home_page_data
  end

  def liked_index
    liked_page_data = LikedPageCollator.call
    render locals: liked_page_data
  end

  def like_story
    story_id = params.require(:story_id)
    LikeRepo.new(current_user.id)
      .toggle_like(story_id)

    likers = LikeRepo.fetch_likes(story_id)
    render json: {
      cmd: :update_story_likes,
      story_id: story_id,
      likers: likers
    }
  end
end
