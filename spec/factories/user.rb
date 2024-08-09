FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "Jon#{n}" }
    sequence(:last_name) { |n| "Snow#{n}" }
    sequence(:email) { |n| "tester+#{n}@gmail.com" }
    password         { SecureRandom.hex(6) }
  end
end
