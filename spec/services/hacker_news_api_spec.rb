require "rails_helper"

describe HackerNewsApi do
  describe ".get_top_story_ids" do
    it "makes an http request to hacker news's top stories endpoint" do
      ids = [1,2,3]
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/topstories.json").to_return_json(
        body: ids
      )

      top_story_ids = HackerNewsApi.get_top_story_ids

      expect(top_story_ids).to eq(ids)
    end
  end

  describe ".get_story" do
    it "makes an http request to hacker news's item endpoint" do
      external_id = "1"
      story = { "by" => "foobar", "title" => "bazbot" }
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/#{external_id}.json").to_return_json(
        body: story
      )

      fetched_story = HackerNewsApi.get_story(external_id)

      expect(fetched_story).to eq(story)
    end
  end
end
