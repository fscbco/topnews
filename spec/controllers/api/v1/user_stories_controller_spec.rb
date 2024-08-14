require 'rails_helper'

RSpec.describe Api::V1::UserStoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let(:story) { create(:story) }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe "GET #index" do
    let!(:user_story) { create(:user_story, user: user, story: story) }
    let!(:another_user) { create(:user) }
    let!(:another_user_story) { create(:user_story, user: another_user, story: story) }

    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "returns grouped stories with user emails and current user email" do
      get :index
      json_response = JSON.parse(response.body)
      expect(json_response['current_user_email']).to eq(user.email)
      expect(json_response['stories']).to be_an(Array)
      expect(json_response['stories'].first['user_emails']).to include(user.email, another_user.email)
    end

    it "indicates if the current user has starred a story" do
      get :index
      json_response = JSON.parse(response.body)
      expect(json_response['stories'].first['current_user_starred']).to be true
    end

    it "orders stories by created_at in descending order" do
      newer_story = create(:story, created_at: 1.day.from_now)
      create(:user_story, user: user, story: newer_story)
      get :index
      json_response = JSON.parse(response.body)
      expect(json_response['stories'].first['id']).to eq(newer_story.id)
    end

    context "when an error occurs" do
      before do
        allow(Story).to receive(:joins).and_raise(StandardError.new("Test error"))
      end

      it "returns an error response" do
        get :index
        expect(response).to have_http_status(:internal_server_error)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to include("Test error")
      end
    end
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

    context "when the request is invalid" do
      it "returns status code 422 and error messages" do
        post :create, params: { story_id: nil, title: nil, url: nil }
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to include("Hn can't be blank", "Title can't be blank", "Url can't be blank")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:user_story) { create(:user_story, user: user, story: story) }

    context "when the request is valid" do
      it "destroys the requested user_story" do
        expect {
          delete :destroy, params: { id: story.id }
        }.to change(UserStory, :count).by(-1)
      end

      it "returns status code 200" do
        delete :destroy, params: { id: story.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the user_story doesn't exist" do
      it "returns status code 404" do
        delete :destroy, params: { id: 999 }
        expect(response).to have_http_status(:not_found)
      end

      it "returns an error message" do
        delete :destroy, params: { id: 999 }
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('User story not found')
      end
    end
  end
end