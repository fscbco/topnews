FactoryBot.define do
    factory :story do
        sequence(:hacker_news_id) { |n| n }
        title { "Test Story #{hacker_news_id}" }
        url { "https://example.com/story-#{hacker_news_id}" }
        points { rand(1..1000) }
        comments_count { rand(0..100) }
    end
end