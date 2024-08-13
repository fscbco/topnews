module HackerNews
  class AddNewStories < Base
    attr_reader :story_ids

    def initialize(story_ids)
      @story_ids = story_ids
    end

    def call
      story_ids.each do |story_id|
        next if NewsDetail.find_by(hn_id: story_id)

        @result = HackerNews::CreateItemDetail.new(story_id).call
        break unless @result.success?
      end

      @result || Result.new(false, nil, 'No new stories added')
    end
  end
end
