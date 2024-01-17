require 'rails_helper'

RSpec.describe HackerNewsClient do
  let(:client) { HackerNewsClient.new }
  describe "#fetch_story_ids" do
    it "does return the top 10 stories" do
      VCR.use_cassette("top_stories") do
        resp = client.fetch_story_ids
        expect(resp).to eq([39020365, 39020258, 39019532, 39019119, 39020600, 39017607, 39014652,
          39013194, 39014866, 38999668])
      end
    end
  end

  describe "#fetch_story" do
    it "does return the specified story details" do
      VCR.use_cassette("story_details") do
        resp = client.fetch_story(39020365)
        expect(resp["title"]).to eq("US developers can offer non-app store purchasing, Apple still collect commission")
        expect(resp["url"]).to eq("https://www.macrumors.com/2024/01/16/us-app-store-alternative-purchase-option/")
      end
    end
  end
end
