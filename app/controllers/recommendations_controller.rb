class RecommendationsController < ApplicationController
  before_action :authenticate_user!

  def create
    story = Story.find(params[:story_id])
    recommendation = current_user.recommendations.build(story: story)

    if recommendation.save
      redirect_back fallback_location: root_path, notice: 'Story recommended successfully!'
    else
      redirect_back fallback_location: root_path, alert: 'Unable to recommend the story.'
    end
  end
end
