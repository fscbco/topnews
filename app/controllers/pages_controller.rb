class PagesController < ApplicationController
  def index
    @user = current_user
    HrNewsService.fetch_and_update_stories(25)
    @stories = Story.all.order("created_at DESC")
    @recommendations = Recommendation.where(user: current_user).map(&:story)
  end

  def recommend
    @user = current_user
    HrNewsService.fetch_and_update_stories(25)
    @stories = Story.joins(:recommendations).distinct.order("created_at DESC")
    @recommendations = Recommendation.where(user: current_user).map(&:story)
  end
end
