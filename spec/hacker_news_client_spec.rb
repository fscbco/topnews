require 'rails_helper' # frozen_string_literal: true
require 'HackerNewsClient'



RSpec.describe HackerNewsClient, type: :model do
  it "should pull the latest n story ids from HN API" do
    VCR.use_cassette("hackernews_top_story_ids") do
      limit = 10
      story_ids = HackerNewsClient.get_top_story_ids(10)
      expect(story_ids.length).to eq(limit)
      assert story_ids.is_a?(Array)
      assert story_ids.all? { |i| i.is_a?(Integer) }
    end
  end

  it "should pull the latest n story details from HN API" do
    VCR.use_cassette("hackernews_top_stories_details") do
      limit = 10
      stories = HackerNewsClient.get_top_stories(limit)
      assert stories.length == limit
      assert stories.all? do |story|
        assert story.has_key?("url")
        assert story.has_key?("type")
        assert story["type"] == "story"
      end
    end
  end
end

