class FetchNewsStoriesJob < ApplicationJob
  queue_as :default

  HACKER_NEWS_URL = 'https://hacker-news.firebaseio.com/v0/'.freeze

  def perform
    puts "Performing FetchNewsStoriesJob"
    response = fetch_news_stories

    if response.any?  
      puts "FetchNewsStoriesJob::Perform Processing fetched data in"
      process_data(response)
    else
      puts "FetchNewsStoriesJob::Perform Nothing to process"
    end
  rescue Exception => error
    Rails.logger.error "Failed to fetch data: #{error}"
  end

  
  private

  def fetch_news_story_ids
    puts "Fetching news_story_ids"
    
    news_story_ids_uri      = URI("#{HACKER_NEWS_URL}newstories.json")
    news_story_ids_response = Net::HTTP.get(news_story_ids_uri)
    @fetchedNewsStories     = JSON.parse(news_story_ids_response)

    puts "FetchNewsStoriesJob::FetchNewsStoryIDs got =======> #{@fetchedNewsStories}"

    filter_stories_ids_to_fetch
  end
    
  def fetch_news_stories
    fetch_news_story_ids.map do |news_story_id|
      news_story_id_uri   = URI("#{HACKER_NEWS_URL}item/#{news_story_id}.json")
      news_story_response = Net::HTTP.get(news_story_id_uri)

      puts "FetchNewsStoriesJob::FetchNewsStories fetched =====> #{news_story_id}"

      JSON.parse(news_story_response)
    end
    .sort_by { |news_story| news_story['time'] }
    .reverse
  end

  def process_data(data)
    data.each do |news_story| 
      puts "FetchNewsStoriesJob::ProcessData processed ====> #{news_story["id"]}"

      ns = NewsStory.create(
        id: news_story["id"],
        title: news_story["title"],
        story_type: news_story["type"],  
        url: news_story["url"],
        score: news_story["score"],
        descendants: news_story["descendants"],
        by: news_story["by"],
        time: news_story["time"]
      )

      puts ns.persisted?, "FetchNewsStoriesJob::ProcessData saved ====> #{news_story["id"]}"
    rescue Exception => error
      Rails.logger.error "Failed to save story: #{error}"
    end
  end

  def filter_stories_ids_to_fetch
    existing_news_stories = NewsStory.pluck(:id)
    # filtering fetched news_story_ids ex. [1,2,3,4] - [3,4] => [1,2]
    @fetchedNewsStories - existing_news_stories
  end
end
