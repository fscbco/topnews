class StoriesController < ApplicationController

  def index
    # @stories = Story.first(10)
    @stories = HackerNewsService.new.top_stories
  end

  def starred
    @stories =  Story.where.not(:user_id => nil)
  end

  def user_starred
    @stories =  Story.where(user_id: current_user.id)
  end

  def show
    @story = Story.find_or_initialize_by(:id => params[:id], :user_id => current_user.id)
    @story.save!
  end

  def edit
    @story = Story.find(params[:id])
  end

  def star
    @story = Story.find_or_initialize_by(id: params[:id], user_id: current_user.id, url: params{:url})
    if @story.save!
      redirect_to root_path, notice: "You've starred this story."
    else
      redirect_to root_path, alert: "Unable to star this story."
    end
  end

  def create
    @story = Story.find_or_create_by(id: params[:id], :user_id => current_user.id, title: params[:title])
  if @story.save!
      redirect_to root_path, notice: "You've starred this story."
    else
      redirect_to root_path, alert: "Unable to star this story."
    end
  end
end
