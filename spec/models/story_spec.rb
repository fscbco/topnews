require 'rails_helper'

RSpec.describe Story, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      story = build(:story)
      expect(story).to be_valid
    end

    it 'is not valid without a title' do
      story = build(:story, title: nil)
      expect(story).to_not be_valid
    end

    it 'is not valid without a url' do
      story = build(:story, url: nil)
      expect(story).to_not be_valid
    end

    it 'is not valid with a duplicate url' do
      create(:story, url: 'http://example.com')
      story = build(:story, url: 'http://example.com')
      expect(story).to_not be_valid
    end

    it 'is not valid without a hacker_news_id' do
      story = build(:story, hacker_news_id: nil)
      expect(story).to_not be_valid
    end

    it 'is not valid with a duplicate hacker_news_id' do
      create(:story, hacker_news_id: 123)
      story = build(:story, hacker_news_id: 123)
      expect(story).to_not be_valid
    end
  end

  describe '.find_or_create_by_hacker_news_id' do
    let(:hacker_news_id) { 123 }
    let(:hacker_news_api) { instance_double(HackerNews) }
    let(:story_data) { { "title" => "Test Story", "url" => "http://example.com" } }

    before do
      allow(HackerNews).to receive(:new).and_return(hacker_news_api)
      allow(hacker_news_api).to receive(:item).with(hacker_news_id).and_return(story_data)
    end

    context 'when the story already exists' do
      let!(:existing_story) { create(:story, hacker_news_id: hacker_news_id) }

      it 'returns the existing story' do
        expect(Story.find_or_create_by_hacker_news_id(hacker_news_id)).to eq(existing_story)
      end

      it 'does not create a new story' do
        expect { Story.find_or_create_by_hacker_news_id(hacker_news_id) }.not_to change(Story, :count)
      end
    end

    context 'when the story does not exist' do
      it 'creates a new story' do
        expect { Story.find_or_create_by_hacker_news_id(hacker_news_id) }.to change(Story, :count).by(1)
      end

      it 'returns the new story' do
        new_story = Story.find_or_create_by_hacker_news_id(hacker_news_id)
        expect(new_story).to be_a(Story)
        expect(new_story.hacker_news_id).to eq(hacker_news_id)
        expect(new_story.title).to eq(story_data["title"])
        expect(new_story.url).to eq(story_data["url"])
      end
    end

    context 'when an error occurs' do
      before do
        allow(hacker_news_api).to receive(:item).and_raise(StandardError.new("API Error"))
      end

      it 'logs the error' do
        expect(Rails.logger).to receive(:error).with(/Error finding or creating story #{hacker_news_id}/)
        expect { Story.find_or_create_by_hacker_news_id(hacker_news_id) }.to raise_error(StandardError)
      end

      it 're-raises the error' do
        expect { Story.find_or_create_by_hacker_news_id(hacker_news_id) }.to raise_error(StandardError)
      end
    end
  end

  describe '.find_or_create_by_hacker_news_ids' do
    let(:hacker_news_ids) { [1, 2, 3] }
    let(:existing_story) { create(:story, hacker_news_id: 1) }

    before do
      existing_story
      allow(Story).to receive(:find_or_create_by_hacker_news_id).and_return(build(:story))
    end

    it 'calls find_or_create_by_hacker_news_id for each id that doesnt exist' do
      hacker_news_ids.reject { |id| id == existing_story.hacker_news_id }.each do |id|
        expect(Story).to receive(:find_or_create_by_hacker_news_id).with(id).once
      end
      Story.find_or_create_by_hacker_news_ids(hacker_news_ids)
    end

    it 'returns an array of stories' do
      result = Story.find_or_create_by_hacker_news_ids(hacker_news_ids)
      expect(result).to be_an(Array)
      expect(result.size).to eq(hacker_news_ids.size)
      expect(result).to all(be_a(Story))
    end
  end
end
