# frozen_string_literal: true

class StoriesController < ApplicationController
  include ApiHelper

  def index
    @stories = ApiHelper.fetch_full_stories
  end
end
