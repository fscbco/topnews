class StoryStarsController < ApplicationController
  def create
    story_star = StoryStar.new(user: current_user, story_id: params[:story_id])

    if story_star.save
      flash[:notice] = "Story successfully starred!"
    else
      flash[:notice] = "Unable to star story"
    end

    redirect_to :root
  end
end
