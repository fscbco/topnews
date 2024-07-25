class StoryService
    DEFAULT_NUMBER_OF_STORIES = 15

    attr_reader :user

    def initialize(user = nil)
        @user = user
    end

    def self.get_stories_data(user)
        new(user).get_stories_data
    end

    def self.get_interesting_stories(user)
        new(user).get_interesting_stories
    end

    def get_stories_data
        # Fetch ids of current stories from api
        external_stories_ids = get_stories_ids_from_api
        process_external_story_id_data(external_stories_ids).compact
    end

    def get_interesting_stories
        external_stories_ids = Story.joins(:favorites).distinct.pluck(:external_story_id)
        process_external_story_id_data(external_stories_ids).compact
    end

    private

    def process_external_story_id_data(external_stories_ids)
        external_stories_ids.first(DEFAULT_NUMBER_OF_STORIES).map do |external_story_id| 
            story = find_or_fetch_story(external_story_id)
            next unless story

            generate_story_data_hash(story)
        end
    end

    def generate_story_data_hash(story)
        {
            story: story,
            favorite: get_favorite_user_string(story),
            count: story_favorite_by_users(story).count,
            favorite_by_user: favorite_by_user?(story)
        }
    end

    def get_favorite_user_string(story)
        usernames = story_favorite_by_users(story)
        generate_favorite_user_string(usernames)
    end

    # Return a story object or nil if story is not found and api request fail
    def find_or_fetch_story(external_story_id)
        Story.find_by(external_story_id: external_story_id) || 
        fetch_and_create_story(external_story_id) || 
        nil
    end

    # Call api to get story data and create story if successful
    def fetch_and_create_story(external_story_id)
        fetched_story_data = get_story_data_from_api(external_story_id)
        return nil unless fetched_story_data

        create_story(fetched_story_data)
    end

    def create_story(data)
        story = Story.new
        story.external_story_id = data['id']
        story.title = data['title']
        story.by = data['by']
        story.url = data['url']
        story.time = Time.at(data['time'])
        story.save!
        story
    rescue
        nil
    end

    def generate_favorite_user_string(usernames)
        count = usernames.count
        output = usernames.first(3)
        output << "and #{count - 3} more" if count > 3
        output.join(", ")
    end

    def story_favorite_by_users(story)
        story.users.pluck(:first_name)
    end

    def favorite_by_user?(story)
        story.users.find_by(id: @user).present?
    end

    def get_stories_ids_from_api
        HackerNewsApi.get_current_stories_ids
    end

    def get_story_data_from_api(external_story_id)
        HackerNewsApi.get_story_details(external_story_id)
    end
end