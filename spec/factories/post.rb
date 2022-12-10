FactoryBot.define do
  factory :post do
    sequence(:author) { |n| "author#{n}" }
    sequence(:hn_id) { |n| "12345#{n}" }
    sequence(:title) { |n| "A Great Post Title - #{n}" }
    url { 'https://kasheesh.co'}
    post_type { 'story' }
    hn_created_at { DateTime.now }

    trait :with_stars do
      after(:create) do |post|
        create_list(:star, 3, post: post)
      end
    end
  end
end
