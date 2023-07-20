module HackerNews
  class Api
    def self.refresh_stories
      stories_request = Faraday.get 'https://hacker-news.firebaseio.com/v0/topstories.json'
      return unless stories_request.success?

      story_ids = JSON.parse(stories_request.body)
      existing_stories = Story.where(external_id: story_ids)
      existing_stories.touch_all

      missing_story_ids = story_ids - existing_stories.pluck(:external_id)
      create_new_stories(missing_story_ids)
      remove_stale_stories

      story_ids
    end

    def self.create_new_stories(missing_story_ids)
      missing_story_ids.each do |story_id|
        story_request = Faraday.get "https://hacker-news.firebaseio.com/v0/item/#{story_id}.json"
        next unless story_request.success?

        story_detail = JSON.parse(story_request.body)
        Story.create(external_id: story_detail['id'], title: story_detail['title'], url: story_detail['url'])
      end
    end

    def self.remove_stale_stories
      Story.where('stories.updated_at < ?', 24.hours.ago).where.missing(:stars).delete_all
    end
  end
end
