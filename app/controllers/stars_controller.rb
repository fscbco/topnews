# frozen_string_literal: true

class StarsController < ApplicationController
  def create
    @story = Story.find(params[:story_id])
    @star = Star.find_or_initialize_by(story: @story, user: current_user)
    if @star.save
      flash[:notice] = "#{@story.title} starred!"
    else
      flash[:error] = "#{@story.title} could not be starred!"
    end
    redirect_to stories_path
  end
end
