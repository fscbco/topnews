# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HackerNewsApi do
  let(:fetcher) { instance_double('StoryFetcher') }
  let(:processor) { instance_double('StoryProcessor') }
  let(:max_stories) { 20 }
  let(:hacker_news_api) { described_class.new(fetcher:, processor:, max_stories:) }

  describe '#fetch_stories' do
    let(:story_ids) { (1..30).to_a }
    let(:stories_data) { story_ids[0...max_stories].map { |id| { 'id' => id, 'title' => "Story #{id}" } } }

    before do
      allow(fetcher).to receive(:top_stories_ids).and_return(story_ids)
      allow(fetcher).to receive(:fetch_story) do |id|
        stories_data.find { |story| story['id'] == id }
      end
      allow(processor).to receive(:save_stories)
    end

    it 'fetches only max_stories number of stories' do
      hacker_news_api.fetch_stories
      expect(fetcher).to have_received(:top_stories_ids).once
      expect(fetcher).to have_received(:fetch_story).exactly(max_stories).times
    end

    it 'saves the fetched stories' do
      expect(processor).to receive(:save_stories).with(stories_data)
      hacker_news_api.fetch_stories
    end
  end

  describe '#save_stories' do
    context 'when stories_data is empty' do
      let(:stories_data) { [] }

      it 'does not save stories' do
        expect(processor).not_to receive(:save_stories)
        hacker_news_api.save_stories(stories_data)
      end
    end

    context 'when stories_data is not empty' do
      let(:stories_data) { [{ 'id' => 1, 'title' => 'Story 1' }] }

      it 'saves the stories' do
        expect(processor).to receive(:save_stories).with(stories_data)
        hacker_news_api.save_stories(stories_data)
      end
    end
  end

  describe 'private methods' do
    let(:story_ids) { (1..10).to_a }
    let(:threads) { story_ids.map { |id| instance_double('Thread', value: { 'id' => id, 'title' => "Story #{id}" }) } }

    before do
      allow(hacker_news_api).to receive(:create_fetch_threads).and_return(threads)
      allow(hacker_news_api).to receive(:join_threads).and_call_original
    end

    describe '#create_fetch_threads' do
      it 'creates threads for fetching stories' do
        hacker_news_api.send(:create_fetch_threads, story_ids)
        expect(hacker_news_api).to have_received(:create_fetch_threads).with(story_ids)
      end
    end

    describe '#join_threads' do
      it 'joins the threads and returns the results' do
        result = hacker_news_api.send(:join_threads, threads)
        expect(result).to eq(story_ids.map { |id| { 'id' => id, 'title' => "Story #{id}" } })
      end
    end
  end
end
