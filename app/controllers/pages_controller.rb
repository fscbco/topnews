# frozen_string_literal: true

require 'httparty'

# Controller for top stories
class PagesController < ApplicationController
    def home
        response = HTTParty.get('https://hacker-news.firebaseio.com/v0/topstories.json')

        max_displayed_articles = 30
        article_ids = JSON.parse(response.body)[0...max_displayed_articles] if response.code == 200
        @articles = article_ids.map do |id|
            res = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
            article = JSON.parse(res.body)
            article['hn_url'] = "https://news.ycombinator.com/item?id=#{article['id']}"
            article
        end
    end
end
