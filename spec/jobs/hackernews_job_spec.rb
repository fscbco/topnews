require 'rails_helper'

RSpec.describe HackernewsJob, type: :job do
  it 'should create new stories' do
    VCR.use_cassette("hacker_news_job") do
      expect(HackerNewsClient).to receive(:get_top_stories).and_return(
        [{
           "title" => "HN Title",
           "url" => "http://hackernews.com",
           "id" => 8675309
         }]
      )

      expect(Story).to receive(:upsert).with(
        {
          title: "HN Title",
          url: "http://hackernews.com",
          hn_story_id: 8675309
        },
        unique_by: :hn_story_id
      ).and_return(["id" => 1])

      expect(StoryRanking).to receive(:upsert).with({ story_id: 1, rank: 1 }, :unique_by => [:story_id, :rank])

      HackernewsJob.perform_now
    end
  end
end
