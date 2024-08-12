FactoryBot.define do
  factory :story do
    hackernewsid {SecureRandom.hex(6)}
    sequence(:author) { |n| "hacker+#{n}" }
    sequence(:title)  { |n| "Title # #{n}" }
    sequence(:url)    { |n| "https://google.com/?page=#{n}" }
    hn_created_at { DateTime.now }
  end
end
