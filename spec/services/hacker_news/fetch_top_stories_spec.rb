require 'rails_helper'

describe HackerNews::FetchTopStories do
  describe 'constants' do
    it 'defines TOP_STORIES_URL' do
      expect(defined? described_class::TOP_STORIES_URL).to eq 'constant'
      expect(described_class::TOP_STORIES_URL).to eq 'https://hacker-news.firebaseio.com/v0/topstories.json'
    end
  end

  describe '#call' do
    let(:hn_id) { 123456 }
    let(:mock_response) { [hn_id] }
    let(:mock_story_response) do
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
        stub_request(:get, described_class::TOP_STORIES_URL).
          to_return(body: mock_response.to_json)

        stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/#{hn_id}.json").
          to_return(body: mock_story_response.to_json)
      end

      it 'creates a new Post' do
        expect{ described_class.call }.to change(Post, :count).by(1)
      end

      it 'creates a Post with the correct attributes' do
        described_class.call

        new_post = Post.last
        expect(new_post.hn_id).to eq hn_id.to_s
        expect(new_post.hn_created_at).to eq(Time.at(mock_story_response[:time]).to_datetime)
        expect(new_post.post_type).to eq(mock_story_response[:type])
        expect(new_post.title).to eq(mock_story_response[:title])
        expect(new_post.url).to eq(mock_story_response[:url])
        expect(new_post.author).to eq(mock_story_response[:by])
      end

      it 'does not create a Post that already exists' do
        post = create(:post, hn_id: hn_id)
        expect{ described_class.call }.not_to change(Post, :count)
      end
    end

    context 'when there is an error' do
      let(:error_response) {{ error: 'Permission denied' }}

      before do
        stub_request(:get, described_class::TOP_STORIES_URL).
          to_return(status: :unauthorized, body: error_response.to_json)
      end

      it 'raises an error' do
        expect { described_class.call }.to raise_error StandardError, "#{described_class.name} error - #{error_response[:error]}"
      end
    end
  end
end
