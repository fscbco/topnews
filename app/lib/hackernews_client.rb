require 'net/http'
class HackernewsClient
  # TODO: could save the rest of top stories in memory to avoid duplicate data requests, for pagination.
  def self.get_top_stories(limit = 10)
    uri = URI('https://hacker-news.firebaseio.com/v0/topstories.json')
    response = Net::HTTP.get(uri)

    JSON.parse(response).take(limit)
  rescue StandardError => e
    Rails.logger.error("Failed to get top stories #{e}")
  end

  def self.get_story(id)
    uri = URI("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
    response = Net::HTTP.get(uri)

    JSON.parse(response)
  rescue StandardError => e
    Rails.logger.error("Failed to get story #{id} #{e}")
  end
end
