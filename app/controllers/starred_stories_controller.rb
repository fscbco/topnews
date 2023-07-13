class StarredStoriesController < ApplicationController
  def create
    # Find an existing story by its Hacker News ID, or create a new one if it doesn't exist.
    # This is done using the find_or_create_by method, which first tries to find a record
    # with the given attributes, and if it can't find one, creates a new record.
    story = Story.find_or_create_by(hn_id: story_params[:hn_id]) do |story|
      # If a new story is being created, we set its attributes here
      story.title = story_params[:title]
      story.url = story_params[:url]
      story.hn_url = story_params[:hn_url]
    end

    # Find an existing StarredStory record for this user and story
    if StarredStory.find_by(user_id: starred_story_params[:user_id], story: story)
      flash[:notice] = 'Story already starred.'
    else
      # or create a new one if it doesn't exist.
      starred_story = StarredStory.create(user_id: starred_story_params[:user_id], story: story)
      if starred_story.save
        flash[:notice] = 'Story starred successfully.'
      else
        flash[:alert] = 'There was an error starring the story.'
      end
    end

    redirect_to root_path
  end

  private

  def starred_story_params
    params.permit(:user_id)
  end

  def story_params
    params.permit(:title, :url, :hn_url, :hn_id)
  end
end
