class HomePageCollator
  def self.call(limit: nil, cache_expiry: nil)
    repo = new
    repo.limit = limit if limit.present?
    repo.cache_expiry = cache_expiry if cache_expiry.present?
    repo.execute
  end

  attr_accessor :limit, :cache_expiry

  def initialize
    @scraper = HackerNewsScraper
    @like_repo = LikeRepo
    @limit = nil
    @cache_expiry = 3.minutes # top stories will be in constant flux
  end

  def execute
    story_data = scrape_news_data
    story_ids = extract_story_ids(story_data)
    liker_data = lookup_likes(story_ids)

    {
      story_data: story_data,
      liker_data: liker_data
    }
  end

  private

  attr_reader :scraper, :like_repo

  def scrape_news_data
    scraper.retrieve_top_stories(
      limit: limit,
      cache_expiry: cache_expiry,
      relevant_fields: [
        :id,
        :title,
        :url
      ]
    )
  end

  def extract_story_ids(scraped_data)
    scraped_data.map { |story| story[:id] }
  end

  def lookup_likes(story_ids)
    like_repo.fetch_grouped_likes(story_ids)
  end
end
