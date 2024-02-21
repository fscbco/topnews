# frozen_string_literal: true

class LikedStoriesController < ApplicationController
  include FeedHelper

  def index
    @stories = Story.joins(:likes).includes(:likes).distinct
  end
end
