require "rails_helper"

describe HackerNewsScraper do
  let(:scraper) { described_class.new }

  describe "#fetch_top_story_ids" do
    it "should retrieve a json list of story ids" do
      story_ids = VCR.use_cassette("top_stories") do
        scraper.fetch_top_story_ids
      end

      # this cassette was manually trimmed for length
      expect(story_ids).to match_array [
        41119080,
        41120254,
        41119443
      ]
    end
  end

  describe "#fetch_story_details" do
    it "should retrieve a specific story's meta data" do
      story_details = VCR.use_cassette("story_details_41119080") do
        scraper.fetch_story_details(41119080)
      end

      expect(story_details).to include(
        by: "Brajeshwar",
        descendants: 52,
        id: 41119080,
        kids: [41120013, 41122192, 41121903, 41119817, 41120734, 41121026, 41119579, 41119896, 41119789, 41120995, 41119829],
        score: 125,
        time: 1722433249,
        title: "How great was the Great Oxidation Event?",
        type: "story",
        url: "https://eos.org/science-updates/how-great-was-the-great-oxidation-event"
      )
    end

    it "should be able to interpret a binary response body" do
      story_details = VCR.use_cassette("story_details_41119443") do
        scraper.fetch_story_details(41119443)
      end

      # In order to trim this cassette, I had to set a VCR config option:
      #   req.response.body.force_encoding("UTF-8").
      # But this endpoint definitely returns a binary string response
      expect(story_details).to include(
        by: "darweenist",
        descendants: 59,
        id: 41119443,
        kids: [41122773, 41123293, 41122675],
        score: 77,
        text: "Hey HN! Dawson here from Martin (<a href=\"https:&#x2F;&#x2F;www.trymartin.com\">https:&#x2F;&#x2F;www.trymartin.com</a>). Martin is a better Siri with an LLM brain and deeper integrations with everyday apps.",
        time: 1722435867,
        title: "Launch HN: Martin (YC S23) – Using LLMs to Make a Better Siri",
        type: "story"
      )
    end
  end

  describe "#fetch_stories" do
    it "should retrieve multiple stories' meta data" do
      multi_story_details = VCR.use_cassette("story_details_multi") do
        scraper.fetch_stories([
          41119080,
          41120254,
          41119443
        ])
      end

      # this cassette was manually trimmed for length
      expect(multi_story_details).to match_array [
        {
          by: "Brajeshwar",
          descendants: 63,
          id: 41119080,
          kids: [41122732, 41119817, 41121903],
          score: 143,
          time: 1722433249,
          title: "How great was the Great Oxidation Event?",
          type: "story",
          url: "https://eos.org/science-updates/how-great-was-the-great-oxidation-event"
        },
        {
          by: "BerislavLopac",
          descendants: 236,
          id: 41120254,
          kids: [41123233, 41121444, 41123268],
          score: 212,
          time: 1722440995,
          title: "I prefer rST to Markdown",
          type: "story",
          url: "https://buttondown.email/hillelwayne/archive/why-i-prefer-rst-to-markdown/"
        },
        {
          by: "darweenist",
          descendants: 53,
          id: 41119443,
          kids: [41122773, 41122675, 41121790],
          score: 73,
          text: "Hey HN! Dawson here from Martin (<a href=\"https:&#x2F;&#x2F;www.trymartin.com\">https:&#x2F;&#x2F;www.trymartin.com</a>). Martin is a better Siri with an LLM brain and deeper integrations with everyday apps.",
          time: 1722435867,
          title: "Launch HN: Martin (YC S23) – Using LLMs to Make a Better Siri",
          type: "story"
        }
      ]
    end
  end

  describe ".retrieve_top_stories" do
    it "should do an end to end refresh of top story data" do
      all_top_stories = VCR.use_cassette("top_story_full_refresh") do
        described_class.retrieve_top_stories(
          cache_expiry: 0.seconds,
          relevant_fields: [:title]
        )
      end

      # this cassette was HEAVILY trimmed for length
      expect(all_top_stories).to match_array [
        {
          title: "Suspicious data pattern in recent Venezuelan election"
        },
        {
          title: "How great was the Great Oxidation Event?"
        },
        {
          title: "Launch HN: Martin (YC S23) – Using LLMs to Make a Better Siri"
        }
      ]
    end

    it "can optionally return the top x results" do
      some_top_stories = VCR.use_cassette("top_story_full_refresh") do
        described_class.retrieve_top_stories(
          limit: 2,
          cache_expiry: 0.seconds,
          relevant_fields: [:title]
        )
      end

      # this cassette was HEAVILY trimmed for length
      expect(some_top_stories).to match_array [
        {
          title: "Suspicious data pattern in recent Venezuelan election"
        },
        {
          title: "How great was the Great Oxidation Event?"
        }
      ]
    end
  end
end
