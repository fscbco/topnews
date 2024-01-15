FactoryBot.define do
  factory :hacker_news_story do
    hacker_news_id { 1 }
    by { "MyString" }
    score { 1 }
    time { "2024-01-14 21:01:53" }
    title { "MyString" }
    url { "MyString" }
  end
end
