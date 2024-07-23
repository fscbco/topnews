FactoryBot.define do
  factory :story do
    hn_id { Faker::Number.number(digits: 5) }
    title { Faker::Lorem.sentence }
    url   { Faker::Internet.url }
  end
end

