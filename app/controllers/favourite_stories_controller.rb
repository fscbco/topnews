class FavouriteStoriesController < ApplicationController
  before_action :find_story, only: %i[add remove]

  def index
    @f_stories = FavouriteStory.where(created_at: 6.hours.ago...Time.now()).group(:story).order('count_all DESC').count
  end

  def add
    fav_story = @story.favourite_stories.create(user: current_user)
    unless fav_story.persisted?
      render json: { error: 'Failed to add to favourites' }, status: :unprocessable_entity
      return
    end
    redirect_to root_path
  end

  def remove
    current_user.favourite_stories.where(story: @story).destroy_all
    redirect_to root_path
  end

  private

  def find_story
    @story = Story.find(params[:story_id])
    unless @story.present?
      render json:{error: 'Story not found'}, status: :unprocessable_entity
      return
    end
  end
end
