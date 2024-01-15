class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stories = HackerNewsGateway.new.top_stories
  end
end
