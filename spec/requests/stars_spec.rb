require 'rails_helper'

RSpec.describe "Stars", type: :request do
  let(:user) { User.create(email: "ari@me.com", password: 123456) }
  let(:story) { Story.create(story_id: "story_id") }

  before { sign_in user }

  describe "POST /create" do
    context "with a good request" do
      it "returns http success" do
        post "/stars/create", params: { story_id: story.id, format: :json }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to have_key("star")
      end

      it "creates the star" do
        expect{ 
          post "/stars/create", params: { story_id: story.id, format: :json }
        }.to change(Starrable, :count).by(1)
      end
    end

    context "with a bad request (story doesn't exist)" do      
      it "returns http bad_request" do
        post "/stars/create", params: { story_id: "foo", format: :json }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["error"]).to eq("Validation failed: Story must exist")
      end
    end
  end

  describe "POST /delete" do
    context "with a good request" do
      let!(:star) { Starrable.create(user: user, story: story) }

      it "returns http success" do
        post "/stars/delete", params: { story_id: story.id, format: :json }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to have_key("star")
      end

      it "deletes the star" do
        expect{ 
          post "/stars/delete", params: { story_id: story.id, format: :json }
        }.to change(Starrable, :count).by(-1)
      end
    end

    context "with a bad request (star doesn't exist)" do      
      it "returns http bad_request" do
        post "/stars/delete", params: { story_id: story.id, format: :json }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["error"]).to eq("Delete failed: Could not find star")
      end
    end
  end
end
