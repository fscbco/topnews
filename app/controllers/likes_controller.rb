class LikesController < ApplicationController

  def update
    @story = Story.all.find(params[:id])
    Like.create(user_id: current_user.id, story_id: @story.id)
    redirect_to '/'
  end
end
