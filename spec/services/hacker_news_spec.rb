require "rails_helper"
require "webmock/rspec"

RSpec.describe HackerNews do
  include ActiveJob::TestHelper

  let(:story_ids_response) do
    [36155204].to_json
  end

  let(:story_details_response) do
    {
      'id': 36155204,
      'title': 'Was Modern Art a CIA Psy-Op?',
      'url': 'https://daily.jstor.org/was-modern-art-really-a-cia-psy-op/',
      'by': 'areoform',
      'time': 1175714200
    }.to_json
  end

  let(:null_story_details_response) do
    {}.to_json
  end

  describe ".fetch_and_save_to_stories" do

    context "when request is successful" do
      it "fetches stories and saves record" do
        ids_url = "https://hacker-news.firebaseio.com/v0/topstories.json"
        WebMock.stub_request(:get, ids_url).to_return({ body: story_ids_response })
        details_url = "https://hacker-news.firebaseio.com/v0/item/36155204.json"
        WebMock.stub_request(:get, details_url).to_return({ body: story_details_response })
        HackerNews.fetch_and_save_to_stories
        expect(Story.count).to eq(1)
        story = Story.first
        expect(story.title).to eq("Was Modern Art a CIA Psy-Op?")
        expect(story.author).to eq("areoform")
        expect(story.url).to eq("https://daily.jstor.org/was-modern-art-really-a-cia-psy-op/")
        expect(story.reference_id).to eq(36155204)
        expect(story.posted_at).to eq(Time.at(1175714200).utc)
      end
    end

    context "when request failed" do
      it "does not create a new story" do
        ids_url = "https://hacker-news.firebaseio.com/v0/topstories.json"
        WebMock.stub_request(:get, ids_url).to_return({ body: story_ids_response })
        details_url = "https://hacker-news.firebaseio.com/v0/item/36155204.json"
        WebMock.stub_request(:get, details_url).to_return({ status: 500, body: "error" })
        HackerNews.fetch_and_save_to_stories
        expect(Story.count).to eq(0)
      end
    end
  end

  describe ".get_top_story_ids" do    
    context "when request fails" do
      it "returns an error" do
        ids_url = "https://hacker-news.firebaseio.com/v0/topstories.json"
        WebMock.stub_request(:get, ids_url).to_return({ status: 500, body: "error" })
        expect(Rails.logger).to receive(:error).with("Error getting top story ids - status: 500 Internal Server Error, body: error")
        HackerNews.get_top_story_ids
      end
    end

    context "when request succeeds" do
      it "fetches list of top story ids" do
        ids_url = "https://hacker-news.firebaseio.com/v0/topstories.json"
        request = WebMock.stub_request(:get, ids_url).to_return({ body: story_ids_response })
        expect(request.response.body).to include("36155204")
        HackerNews.get_top_story_ids
      end
    end
  end

  describe ".get_story_details" do
    let(:story) { FactoryBot.create(:story) }

    context "when request fails" do
      it "returns an error" do
        details_url = "https://hacker-news.firebaseio.com/v0/item/36155204.json"
        WebMock.stub_request(:get, details_url).to_return({ status: 500, body: "error" })
        expect(Rails.logger).to receive(:error).with("Error getting top story details - status: 500 Internal Server Error, body: error")
        HackerNews.get_story_details(36155204)
      end
    end

    context "when request succeeds" do
      it "fetches details for story" do
        details_url = "https://hacker-news.firebaseio.com/v0/item/36155204.json"
        request = WebMock.stub_request(:get, details_url).to_return({ body: story_details_response })
        expect(request.response.body).to include("title")
        expect(request.response.body).to include("url")
        expect(request.response.body).to include("id")
        expect(request.response.body).to include("by")
        expect(request.response.body).to include("time")
        HackerNews.get_story_details(36155204)
      end
    end
  end
end
