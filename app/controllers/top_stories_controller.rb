# app/controllers/top_stories_controller.rb
class TopStoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @top_stories = fetch_top_stories
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

  private

  def fetch_top_stories
    response = HTTParty.get('https://hacker-news.firebaseio.com/v0/topstories.json')
    story_ids = JSON.parse(response.body)
    # Fetch additional details for each story using the item endpoint
    stories = story_ids.take(20).map { |story_id| fetch_story_details(story_id) }
    stories.compact! # Remove any nil values in case some stories couldn't be fetched

    # Save the fetched stories to the database if they have titles and URLs
    save_stories(stories)

    # Fetch the 20 most recent Story objects from the database
    Story.last(20)
  end

  def fetch_story_details(story_id)
    response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json")
    JSON.parse(response.body) if response.code == 200
  end

  def save_stories(stories)
    stories.each do |story_data|
      # Check if the 'title' and 'url' are present before creating the story
      next unless story_data['title'].present? && story_data['url'].present?

      # Use 'find_or_create_by' to avoid creating duplicate stories
      Story.find_or_create_by(title: story_data['title'], url: story_data['url']) do |s|
        s.star_count = 0
      end
    end
  end
end
