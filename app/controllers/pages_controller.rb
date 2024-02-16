class PagesController < ApplicationController
  def index
    @user = current_user
    HrNewsService.fetch_and_update_stories(25)
    @stories = Story.limit(25).order("created_at DESC")
  end
end
