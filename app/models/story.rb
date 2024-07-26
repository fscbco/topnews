class Story < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :hacker_news_id, presence: true, uniqueness: true

  def self.find_or_create_by_hacker_news_id(hacker_news_id)
    story = find_by(hacker_news_id: hacker_news_id)
    return story if story
    data = HackerNews.new.item(hacker_news_id)
    url = data["url"] || "https://news.ycombinator.com/item?id=#{hacker_news_id}"
    create!(
      hacker_news_id: hacker_news_id,
      title: data["title"],
      url: url
    )

  rescue StandardError => e
    Rails.logger.error "Error finding or creating story #{hacker_news_id}: #{e.message}"
    raise
  end

  def self.find_or_create_by_hacker_news_ids(hacker_news_ids)
    hacker_news_ids = Array(hacker_news_ids).uniq
    existing_stories = where(hacker_news_id: hacker_news_ids).index_by(&:hacker_news_id)

    hacker_news_ids.map do |id|
      existing_stories[id] || find_or_create_by_hacker_news_id(id)
    end
  end
end
