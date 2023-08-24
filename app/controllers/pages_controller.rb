class PagesController < ApplicationController
  include FavoritesHelper
  before_action :authenticate_user! # Force user to sign in before viewing this page.

  def home
    top_stories_ids = HackernewsClient.get_top_stories
    @top_stories = top_stories_ids.map do |id|
      HackernewsClient.get_story(id)
    end
  end
end
