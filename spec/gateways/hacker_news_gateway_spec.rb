require 'rails_helper'

describe "HackerNewsGateway" do
  describe "top_story_ids" do
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

    it "returns a list of top ids" do
      expect(subject.top_story_ids).to be_instance_of(Array)
    end

    it "filters out ads" do
      expect(subject.top_story_ids.size).to be(2)
    end

    it "upserts the retrieved stories" do
      expect(HackerNewsStory).to receive(:upsert_all)
        .with([
          {hacker_news_id: 1, by: "Jane", score: 1, time: Time.at(111111111), title: 
          "Story 1", url: "http://storyone.com"},
          {hacker_news_id: 2, by: "John", score: 2, time: Time.at(111111112), title: 
          "Story 2", url: "http://storytwo.com"}
        ], unique_by: :hacker_news_id)
      subject.top_story_ids
    end

    it "only returns the number of stories I request" do
      expect(subject.top_story_ids(1).size).to be(1)
    end
  end
end
