require 'rails_helper'

RSpec.describe Api::V1::UserStoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let(:story) { create(:story) }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe "POST #create" do
    let(:valid_attributes) { { story_id: story.hn_id, title: story.title, url: story.url } }

    context "when the request is valid" do
      it "creates a new user_story" do
        expect {
          post :create, params: valid_attributes
        }.to change(UserStory, :count).by(1)
      end

      it "returns status code 201" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context "when the story doesn't exist" do
      it "creates a new story and user_story" do
        new_story_attributes = { story_id: 12345, title: "New Story", url: "http://example.com" }
        expect {
          post :create, params: new_story_attributes
        }.to change(Story, :count).by(1).and change(UserStory, :count).by(1)
      end
    end

    context "when the user_story already exists" do
      before { create(:user_story, user: user, story: story) }

      it "doesn't create a duplicate user_story" do
        expect {
          post :create, params: valid_attributes
        }.not_to change(UserStory, :count)
      end

      it "returns status code 201" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:user_story) { create(:user_story, user: user, story: story) }

    context "when the request is valid" do
      it "destroys the requested user_story" do
        expect {
          delete :destroy, params: { id: user_story.id }
        }.to change(UserStory, :count).by(-1)
      end

      it "returns status code 200" do
        delete :destroy, params: { id: user_story.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the user_story doesn't exist" do
      it "returns status code 404" do
        delete :destroy, params: { id: 999 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end