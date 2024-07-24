FactoryBot.define do
    factory :story do
        external_story_id { 1 }
        title { 'Testing Story Title' }
        url { 'https://reallyrealnews.com/story/1' }
        by { 'the news guy' }
        time { DateTime.now }
    end
end