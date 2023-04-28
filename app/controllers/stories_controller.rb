# frozen_string_literal: true

class StoriesController < ApplicationController
  include ApiHelper

  def index
    # probably don't need this as an instance variable
    @stories = ApiHelper.fetch_full_stories
    render json: @stories
  end
end
