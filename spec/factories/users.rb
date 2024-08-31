FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    sequence(:email) {|i| "j.doe#{i}@example.com" }
    password { 'password123' }
    password_confirmation { password }
  end
end