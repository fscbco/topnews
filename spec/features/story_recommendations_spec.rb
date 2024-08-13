require 'rails_helper'

RSpec.describe "Story Recommendations", type: :feature do
  let(:user) { create(:user) }
  let(:hacker_news) { instance_double(HackerNews) }
  let(:top_story_ids) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }
  let(:stories) { top_story_ids.map { |id| create(:story, hacker_news_id: id) } }

  before do
    allow(HackerNews).to receive(:new).and_return(hacker_news)
    allow(hacker_news).to receive(:top_stories).and_return(top_story_ids)
    allow(Story).to receive(:find_or_create_by_hacker_news_ids).and_return(stories)
  end

  describe "Home page" do
    context "when user is not authenticated" do
      it "redirects to the login page" do
        visit root_path
        expect(current_path).to eq(new_user_session_path)
      end
    end

    context "when user is authenticated" do
      before do
        sign_in user
      end

      it "displays top stories and allows recommending" do
        visit root_path

        expect(page).to have_content("Welcome to Top News")
        expect(page).to have_selector('.story', count: 10)

        stories.each do |story|
          within "#story_#{story.id}" do
            expect(page).to have_link(story.title, href: story.url)
            expect(page).to have_button('Recommend')
          end
        end

        within "#story_#{stories.first.id}" do
          click_button "Recommend"
        end

        expect(page).to have_content("Story recommended successfully")
      end
    end
  end

  describe "Recommendations page" do
    let!(:recommended_stories) do
      10.times.map do |i|
        create(:story).tap do |story|
          create(:recommendation, story: story, created_at: i.days.ago)
        end
      end
    end

    context "when user is not authenticated" do
      it "redirects to the login page" do
        visit recommendations_path
        expect(current_path).to eq(new_user_session_path)
      end
    end

    context "when user is authenticated" do
      before do
        sign_in user
      end

      it "displays recently recommended stories" do
        visit recommendations_path

        expect(page).to have_selector('.story', count: 10)

        recommended_stories.sort_by { |s| s.recommendations.maximum(:created_at) }.reverse.each_with_index do |story, index|
          within(page.all('.story')[index]) do
            expect(page).to have_content(story.title)
            expect(page).to have_link(story.title, href: story.url)
          end
        end
      end
    end
  end

  describe "Recommending and viewing a story" do
    let(:user) { create(:user) }
    let(:hacker_news) { instance_double(HackerNews) }
    let(:top_story_ids) { [1, 2, 3, 4, 5] }
    let(:stories) { top_story_ids.map { |id| create(:story, hacker_news_id: id) } }

    before do
      allow(HackerNews).to receive(:new).and_return(hacker_news)
      allow(hacker_news).to receive(:top_stories).and_return(top_story_ids)
      allow(Story).to receive(:find_or_create_by_hacker_news_ids).and_return(stories)
      sign_in user
    end

    it "allows a user to recommend a story and see it on the recommendations page" do
      visit root_path
      expect(page).to have_content("Welcome to Top News")

      # Remember the title of the first story
      first_story_title = stories.first.title

      # Recommend the first story
      within "#story_#{stories.first.id}" do
        click_button "Recommend"
      end
      expect(page).to have_content("Story recommended successfully")

      visit recommendations_path

      # Check if the recommended story is present and is the first one
      expect(page).to have_selector('.story', minimum: 1)
      expect(page.all('.story').first).to have_content(first_story_title)
    end
  end
end
