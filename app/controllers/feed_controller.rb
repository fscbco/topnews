# frozen_string_literal: true

class FeedController < ApplicationController
  include FeedHelper

  def index
    @top_stories = FetchTopStoriesFromApiService.new(limit: 10).call
  end
end
