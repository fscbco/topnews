class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stories = FetchTopStoriesService.call
    @interesting_stories = Story.joins(:user_stories).distinct.includes([:users])
  end

  def mark_as_interesting
    story = Story.find_or_create_by(hn_id: params[:hn_id], title: params[:title], url: params[:url])
    current_user.user_stories.find_or_create_by(story: story)
    redirect_to root_path, notice: 'Story marked as interesting.'
  end
end
