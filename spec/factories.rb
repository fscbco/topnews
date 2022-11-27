FactoryBot.define do
    factory :user do
      first_name { "Joe" }
      last_name { "Smith" }
      email { "joe@gmail.com" }
      password { "654321" }
    end
end
  