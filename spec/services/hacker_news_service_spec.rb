require 'rails_helper'

RSpec.describe HackerNewsService, type: :service do
  let(:service) { described_class.new }

  before do
    allow(service).to receive(:fetch_story_ids).and_return([1, 2, 3])
    allow(service).to receive(:fetch_story).with(1).and_return({ 'id' => 1, 'title' => 'Story 1', 'url' => 'https://example.com/1' })
    allow(service).to receive(:fetch_story).with(2).and_return({ 'id' => 2, 'title' => 'Story 2', 'url' => 'https://example.com/2' })
    allow(service).to receive(:fetch_story).with(3).and_return({ 'id' => 3, 'title' => 'Story 3', 'url' => 'https://example.com/3' })
  end

  describe '#fetch_top_stories' do
    it 'fetches the top stories from the API' do
      stories = service.fetch_top_stories

      expect(stories.size).to eq(3)
      expect(stories.first).to include('id' => 1, 'title' => 'Story 1', 'url' => 'https://example.com/1')
      expect(stories.second).to include('id' => 2, 'title' => 'Story 2', 'url' => 'https://example.com/2')
      expect(stories.third).to include('id' => 3, 'title' => 'Story 3', 'url' => 'https://example.com/3')
    end

    it 'fetches only the number of stories specified by the limit' do
      stories = service.fetch_top_stories(2)

      expect(stories.size).to eq(2)
      expect(stories.first['id']).to eq(1)
      expect(stories.second['id']).to eq(2)
    end
  end

  describe '#fetch_story_ids' do
    it 'fetches the story IDs' do
      ids = service.send(:fetch_story_ids)

      expect(ids).to eq([1, 2, 3])
    end
  end

  describe '#fetch_story' do
    it 'fetches a single story' do
      story = service.send(:fetch_story, 1)

      expect(story).to include('id' => 1, 'title' => 'Story 1', 'url' => 'https://example.com/1')
    end
  end
end
