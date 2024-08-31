FactoryBot.define do
  factory :feed do    
    after(:build) do |feed|
      feed.stories = []
      Feed::STORIES_TO_PERSIST.times do |i|
        feed.stories << {
          by: "user #{i}",
          descendants: 22,
          id: i,
          kids: [
            41402953,
            41402728,
            41402746,
            41402906,
            41402690,
            41402776,
            41402716,
            41402914
          ],
          score: 56,
          time: 1725036337,
          title: "Story #{i}",
          type: "story",
          url: "https://example.com/story/#{i}/"
        }
      end
    end
  end
end
