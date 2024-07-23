class InterestingStoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @interesting_stories = InterestingStory.includes(:story, :user).all
  end
end