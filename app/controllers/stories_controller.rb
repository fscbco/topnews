class StoriesController < ApplicationController
  before_action :save_new_stories, only: [:index]

  def index
    @top_stories = fetch_stories
  rescue StandardError => e
    flash[:error] = "An error occurred while fetching the top stories: #{e.message}"
    redirect_to root_path
  end

  def starred
    @starred_stories = Story.includes(user_stories: :user).starred.paginate(page: params[:page], per_page: 10)
  rescue StandardError => e
    flash[:error] = "An error occurred while retrieving the starred stories: #{e.message}"
    redirect_to root_path
  end

  def star
    @story = Story.find_by(hacker_news_story_id: params[:id])
    @story.star_by(current_user)
    redirect_to root_path
  rescue ActiveRecord::RecordNotFound => e
    flash[:error] = "Story not found: #{e.message}"
    redirect_to root_path
  end

  private

  def fetch_stories
    uri = URI('https://hacker-news.firebaseio.com/v0/topstories.json')
    response = Net::HTTP.get(uri)
    top_stories_ids = JSON.parse(response)
    top_stories_ids.first(10).map do |story_id|
      uri = URI("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json")
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  rescue StandardError => e
    raise "Failed to fetch stories: #{e.message}"
  end

  def save_new_stories
    stories = fetch_stories
    stories.each do |story|
      Story.find_or_create_by(hacker_news_story_id: story["id"]) do |new_story|
        new_story.title = story["title"]
        new_story.url = story["url"]
      end
    end
  rescue StandardError => e
    flash[:error] = "An error occurred while saving new stories: #{e.message}"
    redirect_to root_path
  end

  def story_params
    params.require(:story).permit(:title, :url, :hacker_news_story_id)
  end
end
