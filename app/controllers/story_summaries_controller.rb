class StorySummariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @story_summaries = StorySummary.all
  end
end
