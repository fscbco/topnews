class PagesController < ApplicationController
  def index
    @user = current_user

    @stories = Story.where(HackerRankNews.new.get_top_stories.first(25).include?(:story_id))
  end
end
