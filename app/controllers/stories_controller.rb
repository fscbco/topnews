class StoriesController < ApplicationController

  before_action :authenticate_user!, only: [:like, :unlike]

  def index
    sort = (params[:sort] || 'top').to_sym
    story_ids = []

    case sort
      when :new
        story_ids = HackerNewsService.instance.new_stories
      when :top
        story_ids = HackerNewsService.instance.top_stories
      when :best
        story_ids = HackerNewsService.instance.best_stories
      else
        head :bad_request
    end

    @stories = Story.get_stories(story_ids)
    @story_likes = StoriesHelper.get_story_likes(story_ids)
  end

  # GET /likes
  def index_liked
    likes = Like.all
    ids = likes.pluck(:story_id).uniq
    @stories = Story.get_stories(ids)
    users = User.get_first_names(likes.pluck(:user_id).uniq)
    @story_likes = {}
    likes.each do |like|
      @story_likes[like.story_id] ||= {}
      @story_likes[like.story_id][like.user_id] = users[like.user_id]
    end
    render :index
  end

  # GET /stories/:id
  def show
    @story = Story.get_story(params[:id])
    @story_likes
  end

  # PUT /stories/:id/like
  def like
    @story = Story.find(params[:id])
    like = Like.find_by(story_id: @story.id, user_id: current_user.id)
    Like.create(story_id: @story.id, user_id: current_user.id) unless like
    render :show
  end

  # PUT /stories/:id/unlike
  def unlike
    @story = Story.find(params[:id])
    like = Like.find_by(story_id: @story.id, user_id: current_user.id)
    like.destroy if like
    render :show
  end
end


