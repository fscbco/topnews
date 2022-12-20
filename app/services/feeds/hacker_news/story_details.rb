module Feeds
  module HackerNews
    # Returns the details for the story id provided.
    class StoryDetails < BaseService
      include Serviceable
      include Sourceable

      attr_reader :story_id

      def initialize(story_id)
        raise ArgumentError, 'story_id is blank?' if story_id.blank?

        @story_id = story_id
        super URI("#{BASE_URI}/v0/item/#{story_id}.json")
      end

      def execute
        # TODO: Retrieve and return story from cache if available.

        response = request
        unless response.status == 200
          raise "Error calling '#{SOURCE}' service: http status: #{response.status}"
        end

        JSON.parse(response.body)
      end
    end
  end
end
