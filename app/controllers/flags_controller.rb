class FlagsController < ApplicationController
  before_action :authenticate_user!

  def create
    story_data = HackerNewsService.new.fetch_story(params[:story_id])
    if story_data
      story = Story.find_or_create_by(id: story_data['id']) do |s|
        s.title = story_data['title']
        s.url = story_data['url']
      end
      current_user.flagged_stories << story unless current_user.flagged_stories.exists?(story.id)
      redirect_to stories_path, notice: 'Story flagged successfully.'
    else
      redirect_to stories_path, alert: 'Story not found.'
    end
  end

  def destroy
    story = Story.find(params[:story_id])
    current_user.flagged_stories.delete(story)
    redirect_to stories_path, notice: 'Story unflagged successfully.'
  end
end
