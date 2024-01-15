require 'rails_helper'

describe "HackerNewsGateway" do
  describe "top_stories" do
    let(:api) do
      stub = double("HackerNewsApi")
      allow(stub).to receive(:top_story_ids) { [1,2] }
      allow(stub).to receive(:fetch_stories).with([1]) {[
        {id: 1, by: "Jane", score: 1, time: 111111111, title: 
        "Story 1", url: "http://storyone.com"}
      ]}
      allow(stub).to receive(:fetch_stories).with([1,2]) {[
        {id: 1, by: "Jane", score: 1, time: 111111111, title: 
        "Story 1", url: "http://storyone.com"},
        {id: 2, by: "John", score: 2, time: 111111112, title: 
        "Story 2", url: "http://storytwo.com"}
      ]}
      stub
    end

    subject { HackerNewsGateway.new(api) }

    it "returns an array of HackerNewsStory objects" do
      expect(subject.top_stories).to be_instance_of(Array)
      expect(subject.top_stories.size).to be(2)
      expect(subject.top_stories[0]).to be_instance_of(HackerNewsStory)
    end

    it "transforms the epoch time to a Time object" do
      expect(subject.top_stories[0].time).to be_instance_of(Time)
    end

    it "only returns the number of stories I request" do
      expect(subject.top_stories(1).size).to be(1)
    end
  end
end
