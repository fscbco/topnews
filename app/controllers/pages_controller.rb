require 'will_paginate/array'

class PagesController < ApplicationController
  def home
    require 'net/http'
    require 'json'

    # Fetch the top story IDs from the Hacker News API
    uri = URI('https://hacker-news.firebaseio.com/v0/topstories.json')
    all_top_story_ids = JSON.parse(Net::HTTP.get(uri))

    # Paginate the top story IDs
    per_page = 10
    current_page = params[:page] ? params[:page].to_i : 1
    paginated_story_ids = all_top_story_ids.paginate(page: current_page, per_page: per_page)

    # Fetch details for each top story on the current page
    @top_stories = paginated_story_ids.map do |story_id|
      story_uri = URI("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json")
      JSON.parse(Net::HTTP.get(story_uri))
    end

    # Add pagination to the @top_stories array
    @top_stories = WillPaginate::Collection.create(current_page, per_page, all_top_story_ids.length) do |pager|
      pager.replace(@top_stories)
    end
  end
end
