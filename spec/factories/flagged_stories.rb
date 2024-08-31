FactoryBot.define do  
  factory :flagged_story do
    sequence(:url) {|n| "https://example.com/story#{n}/" }
  end
end
