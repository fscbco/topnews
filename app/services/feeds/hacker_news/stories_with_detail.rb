module Feeds
  module HackerNews
    # Returns story detail for the story ids provided.
    class StoriesWithDetail
      attr_reader :story_ids

      def initialize(story_ids)
        # Do not raise.
        # Let #execute return [] if story_ids.blank?; this way,
        # the consumer isn't burdened with having to check
        # story_ids.blank? before calling this service.
        @story_ids = story_ids
      end

      def execute
        return [] if story_ids.blank?

        story_ids.filter_map do |story_id|
          story_details = StoryDetails.new(story_id).execute.with_indifferent_access
          next unless %i[id title url].all? { |key| story_details.key? key }

          story_details[:feed_item_id] = story_details.delete :id
          story_details.slice(:feed_item_id, :title, :url)
        end
      end
    end
  end
end
