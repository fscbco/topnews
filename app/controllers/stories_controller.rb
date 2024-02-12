class StoriesController < ApplicationController
  def index
    @stories = Story.all.includes(:starred_by_users)
  end
end
