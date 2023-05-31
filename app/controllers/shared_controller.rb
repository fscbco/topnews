require 'faraday'

class SharedController < ApplicationController
  include BookmarksHelper

  def index
    bookmark_counts = Bookmark.group(:story_id).count
    @shared_bookmark_list = []

    bookmark_counts.each do |story_id, count|
      if count > 1
        users = Bookmark.where(story_id: story_id).includes(:user).map { |bookmark| bookmark.user.email }
        story_info = fetch_story_info(story_id)
        @shared_bookmark_list << { story_id: story_id, users: users, story_info: story_info, count: count } if story_info.present?
      elsif count == 1
        user = Bookmark.find_by(story_id: story_id).user.email
        story_info = fetch_story_info(story_id)
        @shared_bookmark_list << { story_id: story_id, user: user, story_info: story_info, count: count } if story_info.present?
      end
    end
  end

  def fetch_story_info(story_id)
    url = "https://hacker-news.firebaseio.com/v0/item/#{story_id}.json"
    response = Faraday.get(url)

    if response.success?
      JSON.parse(response.body)
    else
      nil
    end
  end
end
