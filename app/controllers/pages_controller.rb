# Required libraries for making HTTP requests and parsing JSON
require 'net/http'
require 'json'

# Define PagesController which inherits from ApplicationController
class PagesController < ApplicationController
  # Define home method which is a controller action
  def home
    # URL of the endpoint that provides the top story IDs
    url = 'https://hacker-news.firebaseio.com/v0/topstories.json'
    # Parse the URL into a URI object
    uri = URI(url)
    # Make a GET request to the URI
    response = Net::HTTP.get(uri)
    # Parse the JSON response into an array of story IDs, and take the first 8
    story_ids = JSON.parse(response).take(3)

    # For each story ID
    @stories = story_ids.map do |id|
      # Construct the URL of the endpoint that provides the story's details
      story_url = "https://hacker-news.firebaseio.com/v0/item/#{id}.json"
      # Parse the URL into a URI object
      story_uri = URI(story_url)
      # Make a GET request to the URI
      story_response = Net::HTTP.get(story_uri)
      # Parse the JSON response into a Ruby hash and return it from the block
      story = JSON.parse(story_response)

      # Return a hash with the story's details
      {
        id: id,
        title: story['title'],
        url: story['url'],
        hn_url: "https://news.ycombinator.com/item?id=#{id}"
      }
    end

    @starred_stories = StarredStory.includes(:user, :story)
  end
end
