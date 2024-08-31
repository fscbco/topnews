FactoryBot.define do  
  factory :flagged_story do
    sequence(:title) {|n| "Story #{n}/" }
    sequence(:url) {|n| "https://example.com/story#{n}/" }
  end
end
