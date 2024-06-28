# frozen_string_literal: true

FactoryBot.define do
  factory :story do
    hacker_news_id { Faker::Number.between(from: 1, to: 30) }
    author { Faker::Name.name }
    time { Date.today }
    title { 'Peter Piper picked a peck of pickled pepper' }
    url { Faker::Internet.url }
  end
end
