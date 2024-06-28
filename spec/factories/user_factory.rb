# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'GetSchw1fty123' }
    password_confirmation { 'GetSchw1fty123' }
    first_name { 'Rick' }
    last_name { 'Sanchez' }
  end
end
