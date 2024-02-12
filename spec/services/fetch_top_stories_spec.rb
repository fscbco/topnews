require "rails_helper"

describe FetchTopStories do
  describe ".call" do
    it "gets and creates stories from the hacker news api" do
      hacker_news_api = double
      allow(hacker_news_api).to receive(:get_top_story_ids).and_return([5,6])
      allow(hacker_news_api).to receive(:get_story).with(5).and_return({"by" => "author5", "title" => "title5"})
      allow(hacker_news_api).to receive(:get_story).with(6).and_return({"by" => "author6", "title" => "title6"})

      expect {
        FetchTopStories.call(hacker_news_api: hacker_news_api)
      }.to change {
        Story.count
      }.by(2)
    end
  end
end
