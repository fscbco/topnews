# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @top_stories = Story.not_deleted.not_dead.take( 20 ).map( &:decorate )
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
    current_user.stories.decorate
  end

  def _team_stories
    Story.where.associated( :flagged_stories ).decorate
  end
end
