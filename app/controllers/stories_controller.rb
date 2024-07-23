# app/controllers/stories_controller.rb
class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stories = Story.fetch_top_stories.take(10).map { |story_id| Story.fetch_story_details(story_id) }
  end

  def mark_interesting
    story_details = Story.fetch_story_details(params[:id].to_i)
    @story = Story.find_or_initialize_by(story_id: story_details["id"])
    @story.update(story_params(story_details))

    InterestingStory.create(user: current_user, story: @story)

    redirect_to interesting_stories_path, notice: 'Story marked as interesting.'
  end

  private

  def story_params(details)
    {
      title: details["title"],
      url: details["url"],
      by: details["by"],
      score: details["score"],
      time: Time.at(details["time"]),
      descendants: details["descendants"],
      story_type: details["type"]
    }
  end
end