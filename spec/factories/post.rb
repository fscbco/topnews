FactoryBot.define do
  factory :post do
    score { Faker::Number.number(digits: 3) }
    posted_at { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    title { Faker::Lorem.sentence }
    post_type { 'story' }
    url { Faker::Internet.url }
    post_author { create(:post_author) }
  end
end
