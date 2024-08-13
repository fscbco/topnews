module HackerNews
  class AddNewStories < Base
   

    def call
      response = get_new_stories

      if response.class.name == 'Net::HTTPOK'
        ## get news item details.
        
        story_ids = get_new_stories

        story_ids = JSON.parse(response.body)      
        most_recent_id = NewsDetail.most_recent_story.hn_id
        story_ids.each do |story_id|
          break if story_id <= most_recent_id
          HackerNews::CreateItemDetail.new(story_id).call

        end

      else
        ### do something on failure
      end

      
    end


    
  end

end


