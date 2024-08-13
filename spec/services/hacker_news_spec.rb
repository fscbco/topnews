require 'rails_helper'
require 'webmock/rspec'

RSpec.describe HackerNews do
  let(:service) { HackerNews.new }

  describe '#top_stories' do
    let(:top_stories_url) { 'https://hacker-news.firebaseio.com/v0/topstories.json' }

    context 'when the API request is successful' do
      before do
        stub_request(:get, top_stories_url)
          .to_return(status: 200, body: [1, 2, 3, 4, 5].to_json)
      end

      it 'returns the parsed version of the body' do
        expect(service.top_stories).to eq([1, 2, 3, 4, 5])
      end
    end

    context 'when the API request fails' do
      before do
        stub_request(:get, top_stories_url).to_return(status: 500)
      end

      it 'raises an HTTP error' do
        expect { service.top_stories }.to raise_error(HTTParty::ResponseError)
      end
    end

    context 'when the API returns an invalid JSON' do
      before do
        stub_request(:get, top_stories_url)
          .to_return(status: 200, body: 'Invalid JSON')
      end

      it 'raises a JSON parse error' do
        expect { service.top_stories }.to raise_error(JSON::ParserError)
      end
    end
  end

  describe '#item' do
    let(:item_id) { 123 }
    let(:item_url) { "https://hacker-news.firebaseio.com/v0/item/#{item_id}.json" }

    context 'when the API request is successful' do
      let(:item_data) do
        {
          id: item_id,
          title: 'Test Story',
          url: 'https://example.com',
          by: 'user123'
        }
      end

      before do
        stub_request(:get, item_url)
          .to_return(status: 200, body: item_data.to_json)
      end

      it 'returns the item data' do
        expect(service.item(item_id)).to eq(item_data.transform_keys(&:to_s))
      end
    end

    context 'when the item does not exist' do
      before do
        stub_request(:get, item_url).to_return(status: 404)
      end

      it 'raises an HTTP error' do
        expect { service.item(item_id) }.to raise_error(HTTParty::ResponseError)
      end
    end

    context 'when the API returns an invalid JSON' do
      before do
        stub_request(:get, item_url)
          .to_return(status: 200, body: 'Invalid JSON')
      end

      it 'raises a JSON parse error' do
        expect { service.item(item_id) }.to raise_error(JSON::ParserError)
      end
    end
  end
end
