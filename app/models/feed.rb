require 'json'

class Feed < ApplicationRecord
    STORIES_TO_PERSIST = 25

    class << self
        def fetch_and_persist
            obj = self.new
            obj.stories = []
            feed = JSON.parse(Typhoeus.get("https://hacker-news.firebaseio.com/v0/topstories.json").response_body)
            feed.each_index do |i|
                obj.stories << JSON.parse(Typhoeus.get("https://hacker-news.firebaseio.com/v0/item/#{feed[i]}.json").response_body)
                break if i + 1 == STORIES_TO_PERSIST
            end
            obj.save
            obj
        end #fetch_and_persist
    end # class methods
end
