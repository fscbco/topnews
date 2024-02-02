require_relative '../services/hacker_news.rb'

class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  # Home Page: Capture result of HackerNews API call for top stories
  def home
    @stories = HackerNews.top_stories
  end

  # Starred Stories Page: Capture starred stories from stars join table
  def starred_stories
    @starred_stories = Story.includes(:starring_users).where.not(stars: { id: nil })
  end

  # Capture starred story IDs so frontend can properly update Star/Unstar button text
  def starred_story_ids
    user_id = params[:user_id]

    if user_id.present?
      @starred_story_ids = Star.where(user_id: user_id).pluck(:story_id)
      render json: { starred_story_ids: @starred_story_ids }
    else
      render json: { error: 'User ID not provided' }, status: :bad_request
    end
  end
end
