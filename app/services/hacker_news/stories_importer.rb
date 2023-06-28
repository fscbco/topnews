module HackerNews
    class StoriesImporter

        # HN json fields for a story
        TITLE = "title"
        AUTHOR = "by"
        URL = "url"
        EXTERNAL_ID = "id"
        TIME = "time"

        def self.call
            new.call
        end

        def call
            return true if top_story_ids.map(&:to_s).sort == TopStory.latest.external_ids.sort

            ActiveRecord::Base.transaction do
                # We're assuming HN returns max of 500 ids at a time. We should batch ids if max is more.
                new_top_story_ids.each do |story_id|
                    story_data = story_data(story_id) 
                    save_story_data_as_story(story_data)
                end

                save_top_story_ids
            end

            true
        rescue StandardError => e
            Rails.logger.error(e.message)
            false
        end

        def source
            @source ||= ::Source.find_or_create_by(
                name: Source::HACKER_NEWS
            )
        end

        def save_story_data_as_story(story_data)
            Story.create!(
                title: story_data[TITLE],
                author: story_data[AUTHOR],
                url: story_data[URL],
                external_id: story_data[EXTERNAL_ID],
                source: source,
                source_time: story_data[TIME],
            )
        end

        def save_top_story_ids
            TopStory.create!(
                external_ids: top_story_ids,
                source: source
            )
        end

        def read_api(url)
            uri = URI(url)
            response = Net::HTTP.get(uri)
            JSON.parse(response)
        end
    
        def top_story_ids
            @top_story_ids ||= (
                url = "https://hacker-news.firebaseio.com/v0/topstories.json"
                read_api(url)
            )
        end

        def new_top_story_ids
            existing_story_ids = Story.from_hacker_news.where(external_id: top_story_ids).pluck(:external_id)
            top_story_ids.map(&:to_s) - existing_story_ids.map(&:to_s)
        end
    
        def story_data(story_id)
            url = "https://hacker-news.firebaseio.com/v0/item/#{story_id}.json"
            read_api(url)
        end
    end
end