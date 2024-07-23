# spec/factories/stories.rb
FactoryBot.define do
  factory :story do
    title { "Test Story" }
    url { "http://example.com" }
    story_id { 12345 }
    by { "author" }
    score { 100 }
    time { Time.now.to_i }
  end
end