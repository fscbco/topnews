FactoryBot.define do
  factory :post_author do
    name { Faker::Name.name }
  end
end
