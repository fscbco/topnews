FactoryBot.define do
  factory :article do
    external_id { 41247023 }
    # document: document,
    title { "Show HN: If YouTube had actual channels" }
    url { "https://ytch.xyz" }
    type { "story" }
    score { 2554 }
    time { 1723648206 }
    by { "hadisafa" }
  end
end
