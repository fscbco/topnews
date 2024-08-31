class FlaggedStoriesController < ApplicationController

  def add
    raw_url = URI::Parser.new.unescape(params[:url])
    raw_title = URI::Parser.new.unescape(params[:title])
    flagged_story = FlaggedStory.find_or_create_by(url: raw_url, title: raw_title)
    flagged_story.users << current_user
    flagged_story.save
    flash[:notice] = 'Your flag was added to the story'
    redirect_to root_path
  end
  
  def remove
    flagged_story = FlaggedStory.find(params[:id])
    flagged_story.users.destroy(current_user)
    flagged_story.save
    flagged_story.destroy if flagged_story.users.count == 0
    flash[:notice] = 'Your flag was removed from the story'
    redirect_to root_path
  end

end
