FactoryBot.define do
  factory :article do
    sequence(:external_id) { |n| n }
    sequence(:title) { |n| "Show HN: #{n}# Story" }
    sequence(:url) { |n| "https://ytch#{n}.xyz" }
    type { "story" }
    score { rand(1..5000) }
    time { Time.zone.now.to_i }
    sequence(:by) { |n| "hadisafa#{n}" }
  end
end
