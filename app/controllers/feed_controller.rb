# frozen_string_literal: true

class FeedController < ApplicationController
  before_action :authenticate_user!
  include FeedHelper

  def index
    @top_stories = FetchTopStoriesFromApiService.new(limit: 10).call
  end
end
