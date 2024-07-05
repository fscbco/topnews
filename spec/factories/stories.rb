# frozen_string_literal: true

require "ffaker"

FactoryBot.define do
  factory :story do
    by { FFaker::Internet.user_name }
    dead { false }
    deleted { false }
    descendants { 1 }
    kids { [ 1 ] }
    parts { [ 1 ] }
    poll { 99 }
    url { FFaker::Internet.http_url }
    score { 99 }
    title { "MyString" }
    time { 1719060558 }
    story_type { "story" }
  end
end
