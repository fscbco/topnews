#this job pulls story data from hacker news and stories it locally
#upon completion it schedules another job for an hour later

require 'net/http'
class HackerNewsSyncJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    HackerNewsSyncJob.set(wait: 1.hour).perform_later
  end

  def perform
    uri = URI('https://hacker-news.firebaseio.com/v0/topstories.json')
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      top_story_ids = JSON.parse(response.body)
      story_hashes = []
      top_story_ids.each do |id|
        story_uri = URI("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
        story_response = Net::HTTP.get_response(story_uri)
        story = JSON.parse(story_response.body)
        story_hashes << {title: story["title"], url: story["url"] || "https://news.ycombinator.com/item?id=#{story["id"]}",hacker_news_id: story["id"], top: true}
      end
      Story.upsert_all(story_hashes, unique_by: :hacker_news_id)
      Story.where.not(hacker_news_id: top_story_ids).update_all(top: false)
    else
      puts "Failed to fetch top stories. HTTP Status: #{response.code}"
      return nil
    end
    
  end
end
