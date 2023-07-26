# app/controllers/top_stories_controller.rb
class TopStoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    if !Rails.cache.exist?('top_stories')
      TopStoriesService.fetch_and_save_top_stories
    end
    @top_stories = Rails.cache.fetch('top_stories', expires_in: 5.minutes) do
      Story.last(20)
    end
  end

  def flagged_stories
    @flagged_stories = Story.joins(:flags).distinct
  end

  def star
    story = Story.find(params[:id])

    if current_user.flagged_stories.exists?(story.id)
      redirect_to top_stories_index_path, alert: 'You have already starred this story!'
    else
      story.update(star_count: story.star_count + 1)
      current_user.flags.create(story: story)
      redirect_to top_stories_index_path, notice: 'Story starred successfully!'
    end
  end
end
