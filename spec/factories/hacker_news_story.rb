FactoryBot.define do
  factory :hacker_news_story do
    author { "dev" }
    sequence(:hacker_news_id) { |n| n }
    score { 100 }
    hacker_news_timestamp { Time.now.to_i }
    sequence(:title) { |n| "Title #{n}" }
    sequence(:url) { |n| "http://example.com/#{n}" }
  end
end
