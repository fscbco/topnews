module StoriesService
    DEFAULT_NUMBER_OF_STORIES = 15

    def self.get_stories_data
        stories_ids = HackerNewsApi.get_current_stories_ids
        stories_ids.first(DEFAULT_NUMBER_OF_STORIES).map do |id| 
            story = find_or_fetch_story(id)
            next unless story

            user_names = story.users.pluck(:first_name)
            {
                story: story,
                favorite: generate_favorite_user_string(user_names)
            }
        end.compact
    end

    def self.find_or_fetch_story(story_id)
        Story.find_by(story_id: story_id) || 
        fetch_and_generate_story(story_id) || 
        nil
    end

    def self.fetch_and_generate_story(story_id)
        fetched_story_data = HackerNewsApi.get_story_details(story_id)
        return nil unless fetched_story_data

        generate_story(fetched_story_data)
    end

    def self.generate_story(data)
        story = Story.new
        story.story_id = data['id']
        story.title = data['title']
        story.by = data['by']
        story.url = data['url']
        story.time = Time.at(data['time'])
        story.save!
        story
    rescue
        nil
    end

    def self.generate_favorite_user_string(user_names)
        count = user_names.count
        output = user_names.first(3)
        output << " and #{count - 3} more" if count > 3
        output.join(", ")
    end
end