require 'rails_helper'

describe Feed do
  context 'Constants' do
    it 'STORIES_TO_PERSIST' do
      expect(described_class::STORIES_TO_PERSIST).to eq 25
    end
  end

  context 'Attributes' do
    it { expect(subject).to have_db_column(:stories).of_type(:jsonb) }
    it { expect(subject).to have_db_column(:created_at).of_type(:datetime) }

    describe '.stories' do
      it 'acts as an Array of Hashes' do
        obj = described_class.new
        expect(obj.stories).to be_nil

        stories = []
        2.times do |i|
          stories << {
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

        obj.stories = stories
        obj.save
        expect(obj.stories.count).to eq 2
        expect(obj.stories.first.class).to eq Hash
      end
    end
  end

  context 'Methods' do
    context ':: Class' do
      describe '::fetch_and_persist' do
        it 'creates a new object' do
          expect { described_class.fetch_and_persist }.to change { described_class.count }.by(1)
        end

        it 'returns an object with the .stories array populated' do
          feed = described_class.fetch_and_persist
          expect(feed.stories.count).to eq described_class::STORIES_TO_PERSIST

          expect(feed.stories.first['url']).to match /https?:\/\/.*/
        end
      end
    end
  end
end
