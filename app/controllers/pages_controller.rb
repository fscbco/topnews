

require 'net/http'
require 'json'

class PagesController < ApplicationController
    before_action :authenticate_user!, only: [:toggle_star]


    # Fetch the data from the api and render it in the home.html.erb if the user is logged in
    # https://hacker-news.firebaseio.com/v0/item/8863.json
    def home
        if user_signed_in?
            url = URI.parse('https://hacker-news.firebaseio.com/v0/item/8863.json')
            response = Net::HTTP.get_response(url)
            @data = JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
        end 
    end


    def toggle_star
        story = fetch_story(params[:id])
        star = current_user.stars.find_by(story_id: story['id'])

        if star
            star.destroy
            
        else
            current_user.stars.create(
                story_id: story['id'],
                story_title: story['title'],
                story_url: story['url']
            )
        end
    
        redirect_to root_path
    end

    def starred_stories
        @starred_stories = current_user.stars
    end

    private

    def fetch_story(id)
    uri = URI("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

end
