module Feeds
  module HackerNews
    # Returns an Array of ids for 500 of the top stories.
    class TopStories < BaseService
      include Limitable
      include Serviceable
      include Sourceable

      def initialize(limit: nil)
        validate_limit!

        @limit = limit

        super URI("#{BASE_URI}/v0/topstories.json")
      end

      def execute
        response = request
        unless response.status == 200
          raise "Error calling '#{SOURCE}' service: http status: #{response.status}"
        end

        ids = JSON.parse(response.body)
        return ids unless greater_than_limit? ids

        ids.sample(limit)
      end
    end
  end
end
