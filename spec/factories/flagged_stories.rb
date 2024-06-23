# frozen_string_literal: true

require "ffaker"

FactoryBot.define do
  factory :flagged_story do
    user
    story_id { 123 }
  end
end
