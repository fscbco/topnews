class PagesController < ApplicationController

  def home
    # TODO: make sure you handle errors here
    url = "https://hacker-news.firebaseio.com/v0/topstories.json"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    story_ids = JSON.parse(response)

    # TODO: put a caching mechanism here for efficiency if time permits

    non_persisted_stories = story_ids.map(&:to_s) - Story.where(story_id: story_ids).pluck(:story_id)
    non_persisted_stories.first(10).each { |story_id| create_story(story_id) }

    @stories = Story.where(story_id: story_ids)
  end

  private

  def create_story(story_id)
    url = "https://hacker-news.firebaseio.com/v0/item/#{story_id}.json"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    params = create_story_params(JSON.parse(response))
    Story.create!(params)
  end

  def create_story_params(res)
    params = res.slice("by", "id", "score", "time", "title", "url")
    params["author"] = params.delete("by")
    params["story_id"] = params.delete("id")
    params["time"] = Time.at(params.delete("time")).to_datetime
    params
  end
end
