require 'net/http'
require 'json'

class NewsController < ApplicationController
  before_action :authenticate_user!

  def index
    request = URI("https://hacker-news.firebaseio.com/v0/topstories.json")
    response = Net::HTTP.get(request)
    external_story_ids = JSON.parse(response)

    @stories = external_story_ids.first(10).map { |id| fetch_story(id) }
    @liked_stories = Story.with_likes
  end

  def like_story
    external_id = params[:id]

    if !(story = Story.find_by(external_id: external_id))
      story_data = fetch_story(external_id)
      story = Story.create(external_id: external_id, title: story_data['title'], url: story_data['url'])
    end

    like = story.likes.build(user: current_user)
    if like.save
      redirect_to root_path, notice: "You liked a story!"
    end
  end

  private

  def fetch_story(id)
    request = URI("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
    response = Net::HTTP.get(request)
    JSON.parse(response)
  end
end
