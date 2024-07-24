class StoriesService
    DEFAULT_NUMBER_OF_STORIES = 15

    def initialize(user_id = nil)
        @user_id = user_id
    end

    def self.get_stories_data(user_id)
        new(user_id).get_stories_data
    end

    def self.get_favorite_user_string(story)
        new.get_favorite_user_string(story)
    end

    def get_stories_data
        stories_ids = HackerNewsApi.get_current_stories_ids
        story_data(stories_ids).compact
    end

    def get_favorite_user_string(story)
        user_names = story_favorite_by_users(story)
        generate_favorite_user_string(user_names)
    end

    private

    def story_data(stories_ids)
        stories_ids.first(DEFAULT_NUMBER_OF_STORIES).map do |id| 
            story = find_or_fetch_story(id)
            next unless story

            generate_story_data_hash(story)
        end
    end

    def generate_story_data_hash(story)
        {
            story: story,
            favorite: get_favorite_user_string(story),
            count: story_favorite_by_users(story).count,
            favorite_by_user: story.users.find_by(id: @user_id).present?
        }
    end

    # Return a story object or nil if story is not found and api request fail
    def find_or_fetch_story(story_id)
        Story.find_by(story_id: story_id) || 
        fetch_and_create_story(story_id) || 
        nil
    end

    def fetch_and_create_story(story_id)
        fetched_story_data = HackerNewsApi.get_story_details(story_id)
        return nil unless fetched_story_data

        create_story(fetched_story_data)
    end

    def create_story(data)
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

    def generate_favorite_user_string(user_names)
        count = user_names.count
        output = user_names.first(3)
        output << " and #{count - 3} more" if count > 3
        output.join(", ")
    end

    def story_favorite_by_users(story)
        story.users.pluck(:first_name)
    end
end