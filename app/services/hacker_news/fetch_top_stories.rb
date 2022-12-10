module HackerNews
  class FetchTopStories
    TOP_STORIES_URL = 'https://hacker-news.firebaseio.com/v0/topstories.json'.freeze

    def initialize
    end

    def self.call(**args)
      self.new(**args).call
    end

    def call
      uri = URI(TOP_STORIES_URL)
      response = Net::HTTP.get_response(uri)
      parsed_response_body = JSON.parse(response.body)

      case response
      when Net::HTTPSuccess, Net::HTTPOK
        # parsed_response_body is an Array of story IDs
        parsed_response_body.each do |hn_id|
          next if Post.find_by(hn_id: hn_id)

          story_json = HackerNews::FetchStoryById.call(id: hn_id)
          HackerNews::CreatePostFromJson.call(data: story_json)
        end
      else
        raise_error(error: parsed_response_body.dig('error'))
      end
    end

    private

    def raise_error(error: nil)
      error_msg = "#{self.class.name} error - #{error}"
      raise StandardError, error_msg
    end
  end
end
