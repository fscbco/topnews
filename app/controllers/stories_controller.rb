# frozen_string_literal: true

class StoriesController < ApplicationController
  include ApiHelper
  before_action :authenticate_user!

  def index
    stories = ApiHelper.fetch_full_stories
    render json: stories
  end
end
