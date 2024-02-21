# frozen_string_literal: true

class LikedStoriesController < ApplicationController
  before_action :authenticate_user!
  include FeedHelper

  def index
    @stories = Story.joins(:likes).includes(:likes).distinct
  end
end
