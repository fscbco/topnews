class HackerNewsRecommendationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @recommendation = current_user.hacker_news_recommendations.new(hacker_news_story_id: params[:hacker_news_story_id])

    if @recommendation.save
      redirect_to root_path, notice: 'Story recommended successfully.'
    else
      redirect_to root_path, alert: 'Unable to recommend story.'
    end
  end

  def destroy
    @recommendation = current_user.hacker_news_recommendations.find(params[:id])

    if @recommendation.destroy
      redirect_to root_path, notice: 'Recommendation removed successfully.'
    else
      redirect_to root_path, alert: 'Unable to remove recommendation.'
    end
  end
end
