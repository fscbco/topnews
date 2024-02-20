class RecommendationsController < ApplicationController
  before_action :set_story, only: [:create, :destroy]

  def create
    @recommended = Recommendation.create(user: current_user, story: @story)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def destroy
    @recommended = Recommendation.find_by(user: current_user, story: Story.find(params[:story_id]))
    @recommended.destroy if @recommended.present?
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  private

  def set_story
    @story = Story.find(params[:story_id])
  end
end
