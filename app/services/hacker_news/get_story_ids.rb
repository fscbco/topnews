module HackerNews
  class GetStoryIds < Base
    def call
      response = get_new_stories

      if response.class.name == 'Net::HTTPOK'
        ## get news item details.

        story_ids = get_new_stories
        story_ids = JSON.parse(response.body)
        Result.new(true, story_ids, '')
      else
        Result.new(false, nil, 'Request to HN failed')
      end
    end
  end
end
