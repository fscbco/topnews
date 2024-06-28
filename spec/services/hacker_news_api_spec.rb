# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HackerNewsApi do
  let(:fetcher) { instance_double('StoryFetcher') }
  let(:processor) { instance_double('StoryProcessor') }
  let(:max_stories) { 5 }
  let(:story_ids) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }
  let(:story_data) { { 'id' => 1, 'by' => 'author', 'time' => Time.now.to_i, 'title' => 'Title', 'url' => 'http://example.com' } }
  let(:stories_data) { [story_data, story_data, story_data, story_data, story_data] }
  let(:api) { described_class.new(fetcher:, processor:, max_stories:) }

  describe '#fetch_stories' do
    before do
      allow(fetcher).to receive(:top_stories_ids).and_return(story_ids)
      allow(fetcher).to receive(:fetch_story).and_return(story_data)
    end

    it 'fetches only the specified maximum number of stories' do
      expect(fetcher).to receive(:fetch_story).exactly(max_stories).times

      stories = api.fetch_stories
      expect(stories.size).to eq(max_stories)
    end

    it 'returns an array of story data' do
      stories = api.fetch_stories
      expect(stories).to all(be_a(Hash))
    end
  end

  describe '#save_stories' do
    it 'calls the save_stories method on the processor' do
      expect(processor).to receive(:save_stories).with(stories_data)
      api.save_stories(stories_data)
    end

    it 'does not call save_stories when the stories_data is empty' do
      expect(processor).not_to receive(:save_stories)
      api.save_stories([])
    end
  end

  describe '#fetch_story_data' do
    it 'fetches story data for a given story ID' do
      allow(fetcher).to receive(:fetch_story).with(1).and_return(story_data)
      result = api.send(:fetch_story_data, 1)
      expect(result).to eq(story_data)
    end
  end

  describe '#create_fetch_threads' do
    it 'creates a thread for each story ID' do
      threads = api.send(:create_fetch_threads, story_ids.first(max_stories))
      expect(threads.size).to eq(max_stories)
      expect(threads).to all(be_a(Thread))
    end
  end

  describe '#join_threads' do
    it 'joins the threads and returns the results' do
      threads = story_ids.first(max_stories).map do
        Thread.new { story_data }
      end

      results = api.send(:join_threads, threads)
      expect(results).to eq([story_data, story_data, story_data, story_data, story_data])
    end
  end
end
