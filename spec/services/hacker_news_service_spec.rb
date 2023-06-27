require 'rails_helper'

RSpec.describe HackerNewsService do
  describe '#top_stories' do
    let(:service) { described_class.new }
    let(:story_ids) { [1, 2, 3, 4, 5] }
    let(:story) { { 'id' => 1, 'title' => 'Test Story', 'url' => 'https://example.com' } }

    before do
      stub_request(:get, 'https://hacker-news.firebaseio.com/v0/topstories.json')
        .to_return(body: story_ids.to_json)

      stub_request(:get, 'https://hacker-news.firebaseio.com/v0/item/1.json')
        .to_return(body: story.to_json)
    end

    it 'returns the top stories from the Hacker News API' do
      result = service.top_stories

      expect(result).to be_an(Array)
      expect(result.first).to eq(story)
    end
  end
end
