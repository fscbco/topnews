FactoryBot.define do
  factory :story do
    sequence(:hacker_news_id) { |n| n.to_s }
    title { "Test Story #{hacker_news_id}" }
    url { "http://example.com/#{hacker_news_id}" }
  end
end
