class StarredStoriesController < ApplicationController

  def index
    @starred_stories = Story.first(10)
  end
  def show
    @story = Story.find(params[:id])
  end
  def edit
    @story = Story.find(params[:id])
  end
  def create
    @starred_story = Story.find_or_initialize_by(id: params[:id], :user_id => current_user.id, :title => params['title'])
  if @starred_story.save
      redirect_to root_path, notice: "You've starred this story."
    else
      redirect_to root_path, alert: "Unable to star this story."
    end
  end
end
