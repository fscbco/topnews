class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_stories

  def index
    @stories = Story.newest_first
  end

  def like; end

  private

  def load_stories
    HackerNewsApi.new.fetch_stories
  end
end
