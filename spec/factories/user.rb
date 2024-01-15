FactoryBot.define do
  factory :user do
    email { "user@test.com" }
    password { "password" }
    password_confirmation { "password" }
    first_name { "John" }
    last_name { "Doe" }
  end
end
