

require 'net/http'
require 'json'

class PagesController < ApplicationController

    # Fetch the data from the api and render it in the home.html.erb if the user is logged in
    # https://hacker-news.firebaseio.com/v0/item/8863.json
    def home
        if user_signed_in?
      url = URI.parse('https://hacker-news.firebaseio.com/v0/item/8863.json')
      response = Net::HTTP.get_response(url)
      @data = JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
    end 
    end


end
