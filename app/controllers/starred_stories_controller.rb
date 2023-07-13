class StarredStoriesController < ApplicationController
  def create
    # Find an existing story by its Hacker News ID, or create a new one if it doesn't exist.
    # This is done using the find_or_create_by method, which first tries to find a record
    # with the given attributes, and if it can't find one, creates a new record.
    story = Story.find_or_create_by(hn_id: params[:story_id]) do |story|
      # If a new story is being created, we set its attributes here
      story.title = params[:title]
      story.url = params[:url]
      story.hn_url = params[:hn_url]
    end

    # Create a new StarredStory record, which represents the fact that a user has
    # starred a story. This record associates the user with the story.
    starred_story = StarredStory.new(user_id: params[:user_id], story: story)

    # Try to save the StarredStory record to the database. If this is successful,
    # show a flash message to let the user know. If there was an error saving the record,
    # show a different flash message.
    if starred_story.save
      flash[:notice] = 'Story starred successfully.'
    else
      flash[:alert] = 'There was an error starring the story.'
    end

    # After attempting to star the story, redirect the user back to the homepage.
    redirect_to root_path
  end
end
