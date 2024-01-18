FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name  { 'Doe' }
    email { 'john@email_provider.com' }
    password { 'Password1' }
  end

  factory :story do
    sequence(:title) { |n| "hacker#{n}" }
    sequence(:url) { |n| "www.#{n}" }
  end

  factory :user_story do
    story
    user
  end
end
