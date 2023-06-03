FactoryBot.define do
  factory :story do
    title { Faker::Lorem.sentence }
    url { Faker::Internet.url }
    author { Faker::Lorem.word }
    posted_at { 1.day.ago }
    reference_id { Faker::Number.binary(digits: 8) }
  end
end

