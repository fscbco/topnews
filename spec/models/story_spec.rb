# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story, type: :model do
  describe '#update_story' do
    it 'updates the story' do
      story = Story.new(hacker_news_id: '420')
      hn_story = {
        'by' => 'test',
        'time' => Time.now.to_i,
        'title' => 'test',
        'url' => 'test'
      }

      story.update_story(hn_story)

      expect(story.by).to eq 'test'
      expect(story.published_at).to be_a Time
      expect(story.title).to eq 'test'
      expect(story.link).to eq 'test'
    end
  end
end
