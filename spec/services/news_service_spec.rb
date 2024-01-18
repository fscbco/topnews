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
    let(:test_id) { 100100100 }

    it "does call hacker news client with correct parameter" do
      expect_any_instance_of(HackerNewsClient).to receive(:fetch_story).with(test_id)
      NewsService.fetch_story(story_id: test_id)
    end
  end

  describe "#fetch_user_stories" do
    context "when there are no stories with a user_story" do
      before {
        FactoryBot.create(:story)
      }
      it "does not return any stories" do
        expect(Story.count).to eq(1)
        expect(NewsService.fetch_user_stories).to be_empty
      end
    end

    context "when there are pre-existing stories with and without a user_story" do
      it "does return only story with user_story" do
        story_no_user_story = FactoryBot.create(:story)
        story_with_user_story = FactoryBot.create(:user_story).story
        stories = NewsService.fetch_user_stories
        expect(stories.size).to eq(1)
        returned_story = stories.first
        expect(returned_story.title).to eq(story_with_user_story.title)
        expect(returned_story.url).to eq(story_with_user_story.url)
      end
    end
  end

  describe "#create_new_like" do
    it "does create a new user story with correct relationships" do
      story_id = FactoryBot.create(:story).id
      user_id = FactoryBot.create(:user).id

      expect do
        NewsService.create_new_like(story_id: story_id, user_id: user_id)
      end.to change { UserStory.count}.by(1)
      last_user_like = UserStory.last
      expect(last_user_like.user_id).to eq(user_id)
      expect(last_user_like.story_id).to eq(story_id)
    end
  end
end
