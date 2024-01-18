require 'rails_helper'

describe NewsService do
  describe "#fetch_stories" do
    let(:title) { 'fake hacker news' }
    let(:url) { 'www.hackernews.com' }

    context "when there are no current stories" do
      it "does fetch and insert into table" do
        expect_any_instance_of(HackerNewsClient).to receive(:fetch_story_ids).and_return([1])
        expect_any_instance_of(HackerNewsClient).to receive(:fetch_story).with(1).and_return(
            {
              "title" => title,
              "url" => url
            }
          )
        NewsService.fetch_stories
        expect(Story.count).to eq(1)
        story = Story.last
        expect(story.title).to eq(title)
        expect(story.url).to eq(url)
      end
    end

    context "when there are existing current stories" do
      it "does not fetch and insert into table" do
        expect_any_instance_of(HackerNewsClient).to_not receive(:fetch_story_ids)
        expect_any_instance_of(HackerNewsClient).to_not receive(:fetch_story)
        seeded_story = FactoryBot.create(:story)
        NewsService.fetch_stories
        expect(Story.count).to eq(1)
        story = Story.last
        expect(story.title).to eq(seeded_story.title)
        expect(story.url).to eq(seeded_story.url)
      end
    end
  end

  describe "#fetch_story" do
  end

  describe "#fetch_user_stories" do
  end

  describe "#create_new_like" do
  end
end
