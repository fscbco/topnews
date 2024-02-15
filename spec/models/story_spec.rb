require 'rails_helper'

RSpec.describe Story, type: :model do
  describe "#hr_news_story" do
    it "calls HackerRankNewsService with correct parameters" do
      story = Story.new(
        id: 1,
        title: "Sample Title",
        by: "Sample Author",
        text: "Sample Text",
        url: "https://example.com",
        score: 10,
        time: Time.now
      )
      hr_news_service = instance_double(HackerRankNewsService)
      expect(HackerRankNewsService).to receive(:new).with(
        story_id: story.id,
        title: story.title,
        by: story.by,
        text: story.text,
        url: story.url,
        score: story.score,
        time: story.time
      ).and_return(hr_news_service)
      expect(hr_news_service).to receive(:get_story).with(story.id)

      story.hr_news_story
    end
  end

  describe "#hn_news_url" do
    it "returns the provided URL if not nil" do
      story = Story.new
      url = "https://example.com"
      expect(story.hn_news_url(url)).to eq(url)
    end

    it "returns a Hacker News URL if the provided URL is nil" do
      story = Story.new
      story_id = 1
      expect(story).to receive(:hr_news_story).and_return(story_id)
      expect(story.hn_news_url(nil)).to eq("https://news.ycombinator.com/item?id=#{story_id}")
    end
  end
end