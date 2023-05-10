FactoryBot.define do
    factory :user do
      first_name { "John" }
      last_name  { "Doe" }
      email { "johndoe@example.com" }
      password { "password" }
    end
  end
