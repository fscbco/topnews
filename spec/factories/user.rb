FactoryBot.define do
  factory :user do
    email { 'test@email.com' }
    password { 'Test@Pass#123' }
    first_name { 'John' }
    last_name { 'Doe' }
  end
end
