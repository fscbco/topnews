class StoriesController < ApplicationController

  @@hacker_base= 'https://hacker-news.firebaseio.com/v0/'

  def index
    top_story_ids = fetch_top_stories
    @stories = fetch_story_details(top_story_ids.first(30))
  end

  private

  def fetch_top_stories
    response = HTTParty.get("#{@@hacker_base}topstories.json")
    JSON.parse(response.body)
  end

  def fetch_story_details(story_ids)
    story_ids.map do |id|
      response = HTTParty.get("#{@@hacker_base}item/#{id}.json")
      JSON.parse(response.body)
    end
  end
end
