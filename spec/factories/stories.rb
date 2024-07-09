FactoryBot.define do
  factory :story do
    sequence(:id) { |n| n }
    title { 'Example Story' }
    url { 'https://example.com' }
  end
end
