class StoriesController < ApplicationController
  before_action :authenticate_user!, only: [:star, :unstar]
  before_action :set_starred_stories, only: [:index, :starred]
  def index
    
    @stories = HackerNewsService.new.fetch_top_stories

    # This was outside of the scope but thought this could be fun to add to the homepage :)
    # Set @current_user_starred_stories if there is a current_user
    if current_user
      # Eager loading to prevent n1
      @current_user_starred_stories = current_user.starred_stories.includes(:stars).distinct
    end

  end

  def starred
    # set_starred_stories handles getting starred stories
  end

  def star
    story = Story.find_or_create_by(hacker_news_id: params[:hacker_news_id], title: params[:title], url: params[:url].presence || '/')
    current_user.stars.create(story: story)
    redirect_back_or_to root_path
  end

  def unstar
    story = Story.find_by(hacker_news_id: params[:hacker_news_id])
    star = current_user.stars.find_by(story: story)
    star&.destroy
    redirect_back_or_to root_path
  end

  private

  def set_starred_stories
    @starred_stories = Story.includes(:starred_by_users).joins(:stars).distinct
  end

end
