# frozen_string_literal: true

class StoriesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_story_id, only: %i[up_vote down_vote]
  
    #display all news feed
    def index
      top_stories = NewsFeedService.fetch_top_news
      feed = NewsFeedService.fetch_info(top_stories)
      @stories = feed
    end

    #display upvotes news stories
    def up_vote
    @votes = update_vote!(1)
    redirect_to :back
    end
    
    def down_vote
    @votes = update_vote!(-1)
    redirect_to :back
    end
    
    private

    def load_story_and_vote
        top_stories = NewsFeedService.fetch_top_news
        feed = NewsFeedService.fetch_info(top_stories)
        @post = feed.find(@story_id)
        @vote = @post.upvotes.where(user_id: current_user.id).first
    end
    
    def update_vote!(new_value)
        if @vote
            authorize @vote, :update?
            @vote.update_attribute(:value, new_value)
        else
            @vote = current_user.votes.build(value: new_value, post: @post)
            authorize @vote, :create?
            @vote.save
        end
    end
    # def upvote
    #     @upvote_count = Upvote.up_votes.count
    # end


    def set_story_id
        @story_id = params[:id]
    end
  end
  