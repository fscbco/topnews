module Stories
  class LikesController < ApplicationController
    def create
      Like.find_or_create_by!(story_id: params[:story_id], user: current_user)
      render(
        turbo_stream: turbo_stream.replace(
          "like_story_#{params[:story_id]}",
          partial: "stories/like",
          locals: { story_id: params[:story_id] }
        )
      )
    end
  end

end