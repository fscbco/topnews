FactoryBot.define do
  factory :story do
    sequence(:hn_id) { |n| n }
    title { "Test Story #{hn_id}" }
    url { "http://example.com/story/#{hn_id}" }
  end
end