class RecommendationsController < ApplicationController
  def create
    @recommend = Recommendation.create(user: current_user, story: Story.find(params[:story_id]))
    # redirect_back(fallback_location: root_path)
  end

  def delete
    @recommend = Recommendation.find_by(user: current_user, story: Story.find(params[:story_id]))
    @recommend.destroy if @recommend.present?
    redirect_back(fallback_location: root_path)
  end
end
