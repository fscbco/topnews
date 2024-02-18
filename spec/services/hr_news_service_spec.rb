require 'rails_helper'

RSpec.describe HrNewsService, type: :service do
  describe '.fetch_and_update_stories' do
    let(:hr_news_stories) { instance_double(HackerRankNews) }
    let(:story_id) { 123 }
    let(:single_story) { { "type" => "story", "url" => "https://example.com", "title" => "Sample Story" } }

    before do
      allow(HackerRankNews).to receive(:new).and_return(hr_news_stories)
      allow(hr_news_stories).to receive(:get_top_stories).and_return([story_id])
      allow(hr_news_stories).to receive(:get_story).with(story_id).and_return(single_story)
    end

    context 'when the story is valid' do
      it 'creates a new story' do
        expect {
          HrNewsService.fetch_and_update_stories
        }.to change { Story.count }.by(1)
      end

      it 'saves the story attributes' do
        HrNewsService.fetch_and_update_stories
        story = Story.last
        expect(story.title).to eq(single_story["title"])
        expect(story.by).to eq(single_story["by"])
        expect(story.text).to eq(single_story["text"])
        expect(story.url).to eq(single_story["url"])
        expect(story.score).to eq(single_story["score"])
        expect(story.time).to eq(Time.at(single_story["time"].to_i))
        expect(story.story_type).to eq(single_story["type"])
      end
    end

    context 'when the story is invalid' do
      before do
        allow_any_instance_of(Story).to receive(:save).and_return(false)
        allow(Rails.logger).to receive(:error)
      end

      it 'logs an error' do
        expect(Rails.logger).to receive(:error).with(/Error saving story/)
        HrNewsService.fetch_and_update_stories
      end

      it 'does not create a new story' do
        expect {
          HrNewsService.fetch_and_update_stories
        }.not_to change { Story.count }
      end
    end
  end
end