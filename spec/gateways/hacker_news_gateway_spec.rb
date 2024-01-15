require 'rails_helper'

describe "HackerNewsGateway" do
  describe "top_stories" do
    let(:api) do
      stub = double("HackerNewsApi")
      allow(stub).to receive(:top_story_ids) { [1,2,3] }
      allow(stub).to receive(:fetch_stories).with([1]) {[
        {"id" => 1, "type" => "story", "by" => "Jane", "score" => 1, "time" => 111111111, "title" => 
        "Story 1", "url" => "http://storyone.com"}
      ]}
      allow(stub).to receive(:fetch_stories).with([1,2,3]) {[
        {"id" => 1, "type" => "story", "by" => "Jane", "score" => 1, "time" => 111111111, "title" => 
        "Story 1", "url" => "http://storyone.com"},
        {"id" => 2, "type" => "story", "by" => "John", "score" => 2, "time" => 111111112, "title" => 
        "Story 2", "url" => "http://storytwo.com"},
        {"id" => 3, "type" => "job", "by" => "John", "score" => 2, "time" => 111111113, "title" => 
        "Story 3", "url" => "http://storythree.com"}
      ]}
      stub
    end

    subject { HackerNewsGateway.new(api) }

    it "returns a collection of HackerNewsStory objects" do
      expect(subject.top_stories).to all(be_a(HackerNewsStory))
    end

    it "filters out ads" do
      expect(subject.top_stories.size).to be(2)
    end

    it "transforms the epoch time to a ActiveSupport::TimeWithZone object" do
      expect(subject.top_stories[0].time).to be_instance_of(ActiveSupport::TimeWithZone)
    end

    it "only returns the number of stories I request" do
      expect(subject.top_stories(1).size).to be(1)
    end
  end
end
