# frozen_string_literal: true

class StoriesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_story_id, only: %i[upvote]
    
  
    #display all news feed
    def index
      top_stories = NewsFeedService.fetch_top_news
      feed = NewsFeedService.fetch_info(top_stories)
      @stories = feed
    end

    #display upvotes news stories
    def upvote
        top_stories = NewsFeedService.fetch_top_news
        feed = NewsFeedService.fetch_info(top_stories)
        @votes = update_vote!(1) if feed.present?        
    end
    
    private
    
    def update_vote!(new_value)
        if @can_vote
            authorize @can_vote, :update?
            @vote.update_attribute(:value, new_value)
        else
            @can_vote = Upvote.new
            
        end
    end

    def current_user_id
    @current_user ||= User.ids.first
    end

    def set_story_id
    @story_id = params[:id]
    end

      # def upvote
    #     @upvote_count = Upvote.up_votes.count
    # end
  end
  