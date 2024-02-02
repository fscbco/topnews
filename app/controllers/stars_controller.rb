class StarsController < ApplicationController
  before_action :authenticate_user!

  # Add starred story for current user
  def create
    @story = Story.find_or_initialize_by(id: params[:story_id])
    
    unless current_user.starred_stories.include?(@story)
      if @story.new_record?
        @story.title = params[:title]
        @story.by = params[:by]
        @story.score = params[:score]
        @story.url = params[:url]
        @story.time = params[:time]
        @story.save
      end
  
      current_user.starred_stories << @story
    end

    head :ok
  end

  # Delete starred story for current user
  # Delete story from stories table if not starred
  def destroy
    @story = Story.find_by(id: params[:story_id])

    if @story.present?
      current_user.starred_stories.delete(@story) 

      if @story.stars.empty?
        @story.destroy
      end
    end

    head :ok
  end
end