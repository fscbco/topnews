# app/models/story.rb
require 'net/http'
require 'json'

class Story < ApplicationRecord
  has_many :interesting_stories
  has_many :users, through: :interesting_stories

  def self.fetch_top_stories
    url = URI.parse('https://hacker-news.firebaseio.com/v0/topstories.json')
    response = Net::HTTP.get_response(url)
    JSON.parse(response.body)
  end

  def self.fetch_story_details(story_id)
    url = URI.parse("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json")
    response = Net::HTTP.get_response(url)
    JSON.parse(response.body)
  end
end