# spec/factories/interesting_stories.rb
FactoryBot.define do
  factory :interesting_story do
    user
    story
  end
end