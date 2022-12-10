require 'rails_helper'

describe HackerNews::FetchStoryById do
  describe '#call' do
    let(:hn_id) { 123456 }
    let(:mock_response) do
      {
        by: 'dhouston',
        descendants: 0,
        id: hn_id,
        kids: [],
        score: 104,
        time: 1175714200,
        title: 'My YC app: Dropbox - Throw away your USB drive',
        type: 'story',
        url: 'http://www.getdropbox.com/u/2/screencast.html'
      }
    end

    context 'when there is not an error' do
      before do
        stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/#{hn_id}.json").
          to_return(body: mock_response.to_json)
      end

      it 'returns the parsed response body' do
        expect(described_class.call(id: hn_id)).to match mock_response.stringify_keys
      end
    end

    context 'when there is an error' do
      let(:error_response) {{ error: 'Permission denied' }}

      before do
        stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/#{hn_id}.json").
          to_return(status: :unauthorized, body: error_response.to_json)
      end

      it 'raises an error' do
        expect { described_class.call(id: hn_id) }.to raise_error StandardError, "#{described_class.name} error - #{error_response[:error]}"
      end
    end

    context 'when no id is provided' do
      it 'raises an error' do
        expect{ described_class.call }.to raise_error ArgumentError
      end
    end
  end
end
