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
    context 'with the default limit' do
      let(:limit) { nil }

      it 'returns top stories with details' do
        VCR.use_cassette('top_news_service') do
          # NOTE:
          # Q. Why not count == 500?
          # A. We cannot be sure of the count that will be returned
          # because we can only process feed items that have all the data
          # we need to create a Feed object; others are discarded.
          expect(top_news_service.execute.count).to eq 458
        end
      end

      it 'returns the expected top stories with details' do
        VCR.use_cassette('top_news_service') do
          top_story = top_news_service.execute.first
          expect(top_story[:feed_item_id]).to eq (34115747)
          expect(top_story[:title]).to eq ('Rotary Keyboard')
          expect(top_story[:url]).to eq ('https://squidgeefish.com/projects/rotary-keyboard/')
        end
      end
    end

    context 'with a non-default limit' do
      let(:limit) { 100 }

      it 'returns the correct amount of feeds' do
        VCR.use_cassette('top_news_service') do
          expect(top_news_service.execute.count).to be <= limit
        end
      end
    end
  end
end
