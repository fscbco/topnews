class TopStory < ApplicationRecord
    belongs_to :source

    scope :from_hacker_news, -> { joins(:source).where(source: { name: Source::HACKER_NEWS }) }

    delegate :hacker_news, to: :source

    after_save :cache_latest_external_ids_from_hacker_news, if: :from_hacker_news?

    LATEST_EXTERNAL_IDS_HACKER_NEWS_CACHE_KEY = "latest_external_ids_hacker_news"

    def from_hacker_news?
        !!source.hacker_news?
    end

    def self.latest_from_hacker_news
        from_hacker_news.order(created_at: :desc).first
    end

    def self.latest_external_ids_from_hacker_news_cache
        Rails.cache.fetch(LATEST_EXTERNAL_IDS_HACKER_NEWS_CACHE_KEY) do
            self.latest_from_hacker_news&.external_ids || []
        end
    end

    def cache_latest_external_ids_from_hacker_news
        Rails.cache.write(LATEST_EXTERNAL_IDS_HACKER_NEWS_CACHE_KEY, external_ids)
    end
end
