require 'rails_helper'

RSpec.describe "Stories", type: :request do

  let(:user) { FactoryBot.create(:user) }
  let(:story) { FactoryBot.create(:story) }

  before do
    sign_in user
  end
  
  describe "GET /index" do
    it "returns a successful response" do
      get stories_path
      expect(response).to have_http_status(:success)
    end

    it "returns list of stories" do
      story1 = FactoryBot.create(:story)
      story2 = FactoryBot.create(:story)
      get stories_path
      expect(response.body).to include(story1.title)
      expect(response.body).to include(story2.title)
    end
  end

  describe 'POST /star' do
    context "with valid params" do
      it "creates a UserStory record" do
        expect {
          post star_story_path(story), params: { id: story.id }
        }.to change(UserStory, :count).by(1)
        expect(UserStory.last.user).to eq user
        expect(UserStory.last.story).to eq story
      end

      it "redirects to the starred stories page" do
        post star_story_path(story), params: { id: story.id }
        expect(response).to redirect_to(starred_stories_path)
      end
    end

    context "with invalid params" do
      it "does not create a UserStory" do
        post "/stories/100/star", params: { id: 100 }
        expect(UserStory.count).to eq 0
      end
    end
  end

  describe "GET /starred" do
    it "returns a successful response" do
      get starred_stories_path
      expect(response).to be_successful
    end

    it "returns list of starred stories with user name" do
      FactoryBot.create(:user_story, story: story, user: user)
      get starred_stories_path
      expect(response.body).to include(story.title)
      expect(response.body).to include(user.name)
    end

    it "does not return stories that are not starred" do
      get starred_stories_path
      expect(response.body).to_not include(story.title)
    end
  end
end
