module StoriesService
    DEFAULT_NUMBER_OF_STORIES = 20

    def self.get_stories_data
        stories_ids = HackerNewsApi.get_current_stories_ids
        stories_ids.first(DEFAULT_NUMBER_OF_STORIES).map do |id| 
            find_or_fetch_story(id) 
        end
    end

    def self.find_or_fetch_story(story_id)
        HackerNewsApi.get_story_details(story_id)
    end
end