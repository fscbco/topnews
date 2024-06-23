# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @top_stories = HackerNews::Client.top_stories.map( &:decorate )
    @team_stories = _team_stories
    @my_stories = _my_stories if current_user.present?
  end

  def show
    @story = HackerNews::Client.story( params[ :id ] ).decorate
  end

  def flag
    story = HackerNews::Client.story( params[ :id ] )
    story.flag! user: current_user

    redirect_to stories_path
  end

  private

  def _my_stories
    current_user
      .flagged_stories
      .pluck( :story_id )
      .uniq.map { |id| HackerNews::Client.story( id ).decorate }
  end

  def _team_stories
    FlaggedStory
      .all
      .select( "story_id" )
      .distinct.pluck( :story_id )
      .map { |id| HackerNews::Client.story( id ).decorate }
  end
end
