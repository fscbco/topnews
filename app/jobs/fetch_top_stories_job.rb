require 'httparty'

class FetchTopStoriesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # get stories list
    response = HTTParty.get('https://hacker-news.firebaseio.com/v0/topstories.json')
    stories = JSON.parse(response.body)

    # get story details and insert
    stories.each do |story_id|
      response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json")
      story_details = JSON.parse(response.body)

      begin
        Article.create!(
            article_id: story_details['id'],
            author: story_details['by'],
            title: story_details['title'],
            url: story_details['url']
        )
      rescue StandardError => e
        Rails.logger.info "skipping invalid story: #{story_details.inspect}"
      end

    end
  end
end