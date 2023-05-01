# frozen_string_literal: true

class StoriesController < ApplicationController
  include ApiHelper
  before_action :authenticate_user!

  def index
    ApiHelper.fetch_full_stories
    stories = Story.includes(:stars)
    stories_with_all_data = []

    stories.each do |story|
      story_hash = { id: story.id, hn_id: story.hn_id, title: story.title, url: story.url, starred: false,
                     starred_by: [] }
      if story.stars.length.positive?
        story_hash[:starred] = true
        story.stars.each do |star|
          story_hash[:starred_by].push(star.user)
        end
      end
      stories_with_all_data.push(story_hash)
    end

    render json: stories_with_all_data
  end

  def star_story
    star = Star.create(story_id: params[:story_id], user_id: current_user.id)
    render json: star
  end
end
