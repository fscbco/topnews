require Rails.root.join('app', 'models', 'story')

class TopStoriesService
    def self.fetch_and_save_top_stories
      response = HTTParty.get('https://hacker-news.firebaseio.com/v0/topstories.json')
      story_ids = JSON.parse(response.body)
      # Fetch additional details for each story using the item endpoint
      stories = story_ids.take(20).map { |story_id| fetch_story_details(story_id) }
      stories.compact! # Remove any nil values in case some stories couldn't be fetched
  
      # Save the fetched stories to the database if they have titles and URLs
      save_stories(stories)
    end
  
    private
  
    def self.fetch_story_details(story_id)
      response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json")
      JSON.parse(response.body) if response.code == 200
    end
  
    def self.save_stories(stories)
      stories.each do |story_data|
        # Check if the 'title' and 'url' are present before creating the story
        next unless story_data['title'].present? && story_data['url'].present?
  
        # Use 'find_or_create_by' to avoid creating duplicate stories
        Story.find_or_create_by(title: story_data['title'], url: story_data['url']) do |s|
          s.star_count = 0
        end
      end
    end
  end
  