require 'rails_helper'

RSpec.describe HackerNewsService do
  let(:service) { described_class.new }

  describe '#fetch_top_story_ids' do
    it 'fetches top story ids from Hacker News API' do
      stub_request(:get, HackerNewsService::HN_TOP_STORIES_URL)
        .to_return(status: 200, body: '[1, 2, 3]')

      expect(service.send(:fetch_top_story_ids)).to eq([1, 2, 3])
    end

    it 'returns nil on failure' do
      stub_request(:get, HackerNewsService::HN_TOP_STORIES_URL)
        .to_return(status: 500)

      expect(service.send(:fetch_top_story_ids)).to eq(nil)
    end
  end

  describe '#fetch_story_details' do
    it 'fetches story details given a story id' do
      stub_request(:get, format(HackerNewsService::HN_ITEM_URL, id: 1))
        .to_return(status: 200, body: '{"id": 1, "title": "Story 1", "url": "http://example.com"}')

      expect(service.send(:fetch_story_details, 1)).to eq({ id: 1, title: 'Story 1', url: 'http://example.com' })
    end

    it 'returns nil on failure' do
      stub_request(:get, format(HackerNewsService::HN_ITEM_URL, id: 1))
        .to_return(status: 404)

      expect(service.send(:fetch_story_details, 1)).to be_nil
    end
  end
end