require 'rails_helper'

describe HackerNews::CreatePostFromJson do
  describe '#call' do
    let(:hn_id) { 123456 }
    let(:data) do
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
      }.stringify_keys
    end

    context 'when the JSON is valid' do
      it 'returns a Post' do
        post = described_class.call(data: data)
        expect(post).to be_a Post
      end

      it 'creates a Post' do
        expect { described_class.call(data: data) }.to change(Post, :count).by(1)
      end

      it 'creates a Post with the correct attributes' do
        post = described_class.call(data: data)
        expect(post.hn_id).to eq hn_id.to_s
        expect(post.hn_created_at).to eq(Time.at(data['time']).to_datetime)
        expect(post.post_type).to eq(data['type'])
        expect(post.title).to eq(data['title'])
        expect(post.url).to eq(data['url'])
        expect(post.author).to eq(data['by'])
      end
    end

    context 'when the url is blank from HackerNews' do
      let(:blank_url_data) do
        {
          by: 'dhouston',
          descendants: 0,
          id: hn_id,
          kids: [],
          score: 104,
          time: 1175714200,
          title: 'My YC app: Dropbox - Throw away your USB drive',
          type: 'story'
        }.stringify_keys
      end

      it 'returns the url to the post on HackerNews' do
        hn_url = "https://news.ycombinator.com/item?id=#{hn_id}"
        post = described_class.call(data: blank_url_data)
        expect(post.url).to eq hn_url
      end
    end

    context 'when no no is provided' do
      it 'raises an error' do
        expect{ described_class.call }.to raise_error ArgumentError
      end
    end

    context 'when there is an error creating a Post' do
      it 'raises an error' do
        post = create(:post, hn_id: hn_id)
        # Try to create a duplicate Post
        expect{ described_class.call(data: data) }.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: Hn has already been taken')
      end
    end
  end
end
