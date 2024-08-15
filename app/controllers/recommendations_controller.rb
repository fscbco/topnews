class RecommendationsController < ApplicationController
  before_action :authenticate_user!

  def create
    Recommendation.create(story_id: params[:story_id], user: current_user)
    redirect_to(stories_view_url)
  end

  def destroy
    Recommendation.first(story_id: params[:story_id], user: current_user).destroy
    redirect_to(stories_view_url)
  end
end
