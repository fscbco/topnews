class BookmarksController < ApplicationController
  
  def create
    @bookmark = current_user.bookmarks.build(story_id: params[:story_id])
    if @bookmark.save
      flash[:notice] = 'Story bookmark shared!'
    else
      flash[:alert] = 'Failed to share story bookmark.'
    end
    redirect_to bookmarked_stories_path 
  end

  def destroy
    story_id = params[:id]
    bookmark = Bookmark.find_by(story_id: story_id, user_id: current_user.id)
    
    if bookmark.present?
      bookmark.destroy
      flash[:notice] = 'Story bookmark removed.'
      redirect_to bookmarked_stories_path
    end
  end
end
