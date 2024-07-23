# spec/models/story_spec.rb
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Story, type: :model do
  describe ".fetch_top_stories" do
    it "returns an array of top story IDs" do
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/topstories.json")
        .to_return(body: "[8863, 8864, 8865]", headers: { 'Content-Type' => 'application/json' })

      top_stories = Story.fetch_top_stories
      expect(top_stories).to eq([8863, 8864, 8865])
    end
  end

  describe ".fetch_story_details" do
    it "returns the details of a story given its ID" do
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/8863.json")
        .to_return(body: {
          "id": 8863,
          "title": "My YC app: Dropbox - Throw away your USB drive",
          "url": "http://www.getdropbox.com/u/2/screencast.html",
          "by": "dhouston",
          "score": 104,
          "time": 1175714200,
          "descendants": 71,
          "type": "story"
        }.to_json, headers: { 'Content-Type' => 'application/json' })

      story_details = Story.fetch_story_details(8863)
      expect(story_details["id"]).to eq(8863)
      expect(story_details["title"]).to eq("My YC app: Dropbox - Throw away your USB drive")
    end
  end
end