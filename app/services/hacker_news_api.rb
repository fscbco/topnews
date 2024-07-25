class HackerNewsApi
    BASE_URL = 'https://hacker-news.firebaseio.com'
    RETRY_LIMIT = 3

    class ApiInternalServiceError < StandardError; end

    attr_accessor :retry_count

    def initialize
        @retry_count = RETRY_LIMIT
    end

    def self.get_current_stories_ids
        new.get_current_stories_ids
    end

    def self.get_story_details(story_id)
        new.get_story_details(story_id)
    end

    def get_current_stories_ids
        default_return = []
        uri = URI("#{BASE_URL}/v0/topstories.json")
        api_request(uri, default_return)
    end

    # Return an object with story data
    def get_story_details(story_id)
        default_return = {}
        return default_return if story_id.blank?
        
        uri = URI("#{BASE_URL}/v0/item/#{story_id}.json")
        api_request(uri, default_return)
    end

    private

    def api_request(uri, default_return)
        response = response(uri)
        handle_response(response) || default_return
    rescue
        if @retry_count > 0
            Rails.logger.info("Retrying request to #{uri}.")
            @retry_count -= 1
            retry 
        else
            Rails.logger.error("Exceeded maximum retries. API request failed with code #{response.code}")
            default_return
        end
    end

    def response(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        headers = {'Accept': 'application/json'}
        request = Net::HTTP::Get.new(uri.request_uri, headers)
        http.request(request)
    end

    def handle_response(response)
        case response.code.to_i
        when 200..299
            JSON.parse(response.body)
        when 400..499
            Rails.logger.error("API request failed with code #{response.code}. Bad Request Error, please check request.")
        when 500..599
            raise ApiInternalServiceError
        end
    end
end