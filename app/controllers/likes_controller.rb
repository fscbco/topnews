# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    story.likes.create(user: current_user)
    redirect_back(fallback_location: feed_index_path)
  end

  private

  def story
    Story.find(params[:story_id])
  end
end
