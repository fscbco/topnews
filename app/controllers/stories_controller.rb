class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stories = Story.page(params[:page]).per(20)
  end
  
  # to improve the UX, I would switch the starring action to be asychronous
  def star
    story = Story.find_by(id: params[:id])
    starred_story = UserStory.find_or_initialize_by(user: current_user, story: story)

    if starred_story.save
      flash[:notice] = "Story saved successfully."
    end
    redirect_to starred_stories_path
  end

  def starred
    @stories = Story.select('stories.*, COUNT(user_stories.id) AS user_story_count').
                    joins(:user_stories).
                    includes(:users).
                    group('stories.id').
                    order('user_story_count DESC').
                    page(params[:page]).per(20)
  end
end
