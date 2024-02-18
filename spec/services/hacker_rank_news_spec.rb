require 'rails_helper'

RSpec.describe HackerRankNews do
  describe '#get_top_stories' do
    it 'fetches top stories successfully' do
      response = HackerRankNews.new.get_top_stories

      expect(response.code).to eq(200)
      expect(response.parsed_response).to be_an_instance_of(Array)
      expect(response.parsed_response.first).to be_an_instance_of(Integer)
    end
  end

  describe '#get_story' do
    it 'fetches a single story by id' do
      top_stories_response = HackerRankNews.new.get_top_stories
      story_id = top_stories_response.parsed_response.first

      response = HackerRankNews.new.get_story(story_id)

      expect(response.code).to eq(200)
      expect(response.parsed_response).to include("id" => story_id)
      expect(response.parsed_response["title"]).not_to be_nil
    end
  end
end
