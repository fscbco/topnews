FactoryBot.define do
  factory :like do
    userid { SecureRandom.hex(6) }
    storyid { SecureRandom.hex(6) }
  end
end
