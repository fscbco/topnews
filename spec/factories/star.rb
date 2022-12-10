FactoryBot.define do
  factory :star do
    association :post
    association :user
  end
end
