require 'rails_helper'

describe "HackerNewsApi" do
  describe "top_story_ids" do
    subject { HackerNewsApi.top_story_ids }

    before do
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/topstories.json")
        .to_return(body: Rails.root.join("spec", "fixtures", "topstories.json"), status: 200)
    end

    it "returns an array of story ids" do
      expect(subject).to be_instance_of(Array)
      expect(subject.length).to be(2)
      expect(subject[0]).to be_instance_of(Integer)
    end
  end

  describe "fetch_stories" do
    subject { HackerNewsApi.fetch_stories([1, 2]) }

    before do
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/1.json")
        .to_return(body: Rails.root.join("spec", "fixtures", "item-1.json"), status: 200)
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/2.json")
        .to_return(body: Rails.root.join("spec", "fixtures", "item-2.json"), status: 200)
    end

    it "returns an array of parsed responses in correct order" do
      expect(subject).to be_instance_of(Array)
      expect(subject[0]["title"]).to eq("Vector Databases: A Technical Primer")
      expect(subject[1]["title"]).to eq("I'm sorry but I cannot fulfill this request it goes against OpenAI use policy")
    end
  end
end
