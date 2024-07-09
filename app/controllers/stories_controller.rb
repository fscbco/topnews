class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_stories, :flagged_stories

  private

  def load_stories
    @stories = HackerNewsService.new.fetch_top_stories
  end

  def flagged_stories
    @flagged_stories = Flag.includes(:story, :user).all.group_by(&:story_id)
  end
end
