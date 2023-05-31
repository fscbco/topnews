require 'faraday'
require 'concurrent'

class MainController < ApplicationController
  include BookmarksHelper
  before_action :authenticate_user!, except: [:index]

  def index
    story_ids = fetch_top_story_ids
    @top_stories = fetch_stories(story_ids)
    @top_stories.sort_by! { |story| -story['time'] }
  end

  def fetch_top_story_ids
    url = "https://hacker-news.firebaseio.com/v0/topstories.json"
    response = Faraday.get(url)

    if response.success?
      JSON.parse(response.body)
    else
      []
    end
  end

  def fetch_stories(story_ids)
    top_stories = Concurrent::Array.new
    
    story_requests = story_ids.each_slice(10).map do |ids_batch|
      Concurrent::Future.execute do
        stories_batch = ids_batch.map { |story_id| fetch_story(story_id) }
        top_stories.concat(stories_batch.compact)
      end
    end

    story_requests.each(&:wait)
    top_stories.flatten
  end

  def bookmarked_stories
    @bookmarked_stories = current_user.bookmarks.pluck(:story_id).compact.map do |story_id|
      fetch_story(story_id)
    end
  end

  def fetch_story(id)
    url = "https://hacker-news.firebaseio.com/v0/item/#{id}.json"
    response = Faraday.get(url)

    if response.success?
      JSON.parse(response.body)
    else
      nil
    end
  end
end
