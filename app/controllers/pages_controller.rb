class PagesController < ApplicationController

  def home
    # TODO: make sure you handle errors here
    url = "https://hacker-news.firebaseio.com/v0/topstories.json"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    story_ids = JSON.parse(response)

    @stories = story_ids.first(20).map do |story_id|
      url = "https://hacker-news.firebaseio.com/v0/item/#{story_id}.json"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  end
end
