class PagesController < ApplicationController
  before_action :get_top_stories, only: [:home, :flag], if: :user_signed_in?
  before_action :get_flagged_stories, only: [:home, :flag], if: :user_signed_in?
  
  def home
    render 'home', :locals => { :top_stories => @top_stories, :flagged_stories => @flagged_stories }
  end

  def flag
    if params[:type] == "flag"
      FlaggedStory.create(story_id: params[:id], user_id: current_user.id)
    else
      FlaggedStory.find_by(story_id: params[:id], user_id: current_user.id).destroy
    end

    redirect_to root_path
  end

  private

  def get_top_stories
    @top_stories = HackerNewsService.get_top_10_story_ids
    @current_user_flagged_stories = FlaggedStory.where(user_id: current_user.id).to_a

    @top_stories = @top_stories.map do |story_id|
      HackerNewsService.get_story_details(story_id)
    end

    @top_stories = @top_stories.map do |top_story|
      if @current_user_flagged_stories.find {|story| story.story_id.to_i == top_story["id"]}
        top_story["flagged"] = true
      else
        top_story["flagged"] = false
      end

      top_story
    end
  end

  def get_flagged_stories
    @flagged_stories = FlaggedStory.all.map do |flagged_story|
      HackerNewsService.get_story_details(flagged_story.story_id)
    end

    @flagged_stories = @flagged_stories.map do |story|
      story["flagged_by"] = FlaggedStory
        .where(story_id: story["id"])
        .map { |flagged_story| User.find(flagged_story.user_id).name }
        .join(", ")
      story
    end.uniq
  end
end
