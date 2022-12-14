# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @stories = HackerNews.new.top_stories_ids
  end
end
