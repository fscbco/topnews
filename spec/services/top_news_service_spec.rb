require 'rails_helper'

RSpec.describe TopNewsService do
  subject(:top_news_service) do
    TopNewsService.new(limit: limit)
  end

  describe '.new' do
    context 'when limit is not a positive integer' do
      let(:limit) { 0 }

      it 'raises an error' do
        expect { top_news_service }.to raise_error 'limit is not positive?'
      end
    end
  end

  describe '#execute' do
    let(:limit) { 500 }

    it 'returns top stories with details' do
      VCR.use_cassette('top_news_service_execute') do
        # NOTE: we cannot be sure of the count that will be returned
        # because we can only process feed items that have all the data
        # we need to create a Feed object; others are discarded.
        expect(top_news_service.execute.count == 458).to eq true
      end
    end

    it 'returns the expected top stories with details' do
      VCR.use_cassette('top_news_service_execute_expected_top_stories') do
        top_story = top_news_service.execute.first
        expect(top_story[:feed_item_id]).to eq (34066824)
        expect(top_story[:title]).to eq ('Show HN: Obsidian Canvas – An infinite space for your ideas')
        expect(top_story[:url]).to eq ('https://obsidian.md/canvas')
      end
    end
  end
end
