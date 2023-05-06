class PagesController < ApplicationController

    def home
        require 'net/http'
        require 'json'

        # Fetch the top story IDs from the Hacker News API
        uri = URI('https://hacker-news.firebaseio.com/v0/topstories.json')
        top_story_ids = JSON.parse(Net::HTTP.get(uri)).take(10)

        # Fetch details for each top story
        @top_stories = top_story_ids.map do |story_id|
          story_uri = URI("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json")
          JSON.parse(Net::HTTP.get(story_uri))
        end
      end
end
