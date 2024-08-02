class LikedPageCollator
  def self.call(cache_expiry: nil)
    repo = new
    repo.cache_expiry = cache_expiry if cache_expiry.present?
    repo.execute
  end

  attr_accessor :cache_expiry

  def initialize
    @scraper = HackerNewsScraper
    @like_repo = LikeRepo
    @cache_expiry = 1.day # story details won't change often, if at all
  end

  def execute
    liker_data = lookup_all_likes
    story_ids = liker_data.keys
    scraped_data = scrape_news_data(story_ids)

    {
      story_data: scraped_data,
      liker_data: liker_data
    }
  end

  private

  attr_reader :scraper, :like_repo

  def lookup_all_likes
    like_repo.fetch_grouped_likes
  end

  def scrape_news_data(story_ids)
    story_ids.map do |story_id|
      scraper.retrieve_story_details(
        story_id: story_id,
        cache_expiry: cache_expiry,
        relevant_fields: [
          :id,
          :title,
          :url
        ]
      )
    end
  end
end
