class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    ids = HackerNewsGateway.new.top_story_ids
    records = HackerNewsStory.where(hacker_news_id: ids).includes(:users).all
    # Sort records by the current HN sort order. 
    @stories = ids.map { |id| records.detect { |record| record.hacker_news_id == id } }.compact
  end

  def like
    story = HackerNewsStory.find(params[:id])
    Like.upsert({hacker_news_story_id: story.id, user_id: current_user.id}, unique_by: [:hacker_news_story_id, :user_id])
    redirect_to action: "index"
  end
end
