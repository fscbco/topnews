# frozen_string_literal: true

require "ffaker"

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    first_name { FFaker::Name.first_name }
    last_name  { FFaker::Name.last_name }
    password { "eeMaev2shai" }
  end
end
