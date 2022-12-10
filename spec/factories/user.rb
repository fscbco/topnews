FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "FirstName#{n}" }
    sequence(:last_name) { |n| "LastName#{n}" }
    sequence(:email) { |n| "test_email_#{n}@test.com" }
    password { 'a1b2c3' }
    password_confirmation { 'a1b2c3' }

    trait :with_starred_posts do
      after(:create) do |user|
        create_list(:star, 3, user: user)
      end
    end
  end
end
