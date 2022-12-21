FactoryBot.define do
  factory :item do
    sequence(:item_id) { |n| n * 100 }
    sequence(:by) { |n| "Writer#{n}" }
    sequence(:title) { |n| "Item Title #{n}" }
    item_created_at { DateTime.now }
    item_type { 'story' }
    url { 'http://example.com' }
  end
end
