FactoryBot.define do
  factory :recommendation do
    association :user
    association :story
  end
end
