require 'resolv-replace'
require 'concurrent'

class StoriesController < ApplicationController
    before_action :authenticate_user!
  
    def index
        @stories = Story.order(created_at: :desc).page(params[:page]).per(20)
    end

    def starred
        @starred_stories = Story.joins(:starred_stories).distinct.order(created_at: :desc)
    end

    def star
        @story = Story.find_by(hacker_news_id: params[:id])
        current_user.star_story(@story)
        respond_to do |format|
          format.html { redirect_back(fallback_location: root_path) }
          format.js
        end
    end

    def unstar
        @story = Story.find_by(hacker_news_id: params[:id])
        current_user.unstar_story(@story)
        respond_to do |format|
          format.html { redirect_back(fallback_location: root_path) }
          format.js
        end
    end

    def fetch_latest_news
        # Fetch top story IDs concurrently
        top_story_ids = fetch_top_story_ids || []
        new_story_ids = top_story_ids - Story.pluck(:hacker_news_id)
    
        puts "#{new_story_ids.count} new story id(s)"

        # Use concurrent-ruby to fetch story data concurrently
        futures = new_story_ids.map do |id|
          Concurrent::Future.execute { fetch_story_data(id) }
        end
    
        # Wait for all futures to complete and get the results
        futures.each do |future|
            story_data = future.value
            next unless story_data
    
            Story.create(
                hacker_news_id: story_data['id'],
                title: story_data['title'],
                url: story_data['url'],
                points: story_data['score'],
                comments_count: story_data['descendants']
            )
        end
    
        @stories = Story.order(created_at: :desc).page(params[:page]).per(20)
        respond_to do |format|
          format.html { redirect_to root_path }
          format.js
        end
    end

    private
  
    def fetch_top_story_ids
        puts "Fetching top story ids via the API"
        start_time = Time.now
        top_story_ids = JSON.parse(Net::HTTP.get(URI('https://hacker-news.firebaseio.com/v0/topstories.json')))
        puts "Top story ids fetched, took #{Time.now - start_time} seconds"
        top_story_ids
    end

    def fetch_story_data(id)
        puts "Fetching story with id #{id} via the API"
        start_time = Time.now
        story_data = JSON.parse(Net::HTTP.get(URI("#{story_url}#{id}.json")))
        puts "Story with id fetched, took #{Time.now - start_time} seconds" 
        story_data
    end

    def story_url
        'https://hacker-news.firebaseio.com/v0/item/'
    end
  end