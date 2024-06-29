# frozen_string_literal: true

FactoryBot.define do
  factory :story do
    sequence(:hacker_news_id) { |n| n }
    author { Faker::Name.name }
    time { Date.today }
    title { 'Peter Piper picked a peck of pickled pepper' }
    url { Faker::Internet.url }
  end
end
