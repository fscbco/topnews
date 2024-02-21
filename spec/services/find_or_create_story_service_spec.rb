# frozen_string_literal: true

require "rails_helper"

RSpec.describe(FindOrCreateStoryService, type: :service, vcr: true) do
  before(:each) do
    Rails.cache.clear
  end

  after(:each) do
    Rails.cache.clear
  end

  describe ".call" do
    # https://hacker-news.firebaseio.com/v0/item/8863.json
    it "fetches the story and creates a new DB object if it doesn't exist" do
      id = 8863

      expect(Story.count).to eq(0)
      response = FindOrCreateStoryService.new(id: id).call
      expect(response.is_a?(Story)).to eq(true)
      expect(Story.count).to eq(1)

      story = Story.last
      api_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/8863.json").to_h
      fetched_id = api_response.dig("id")
      expect(story.raw_data).to eq(api_response)
      expect(story.hacker_news_id).to eq(fetched_id)
    end

    it "will not create a new DB object if it already exists" do
      id = 8863
      api_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/8863.json").to_h
      Story.create!(hacker_news_id: id, raw_data: api_response)

      expect(Story.count).to eq(1)
      response = FindOrCreateStoryService.new(id: id).call
      expect(response.is_a?(Story)).to eq(true)
      expect(Story.count).to eq(1)
    end
  end
end
