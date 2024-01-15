require 'rails_helper'

describe StoriesController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    let(:gateway) { double("HackerNewsGateway") }
    let(:story_ids) { [1,2,3] }

    it "fetches latest ids from gateway" do
      expect(gateway).to receive(:top_story_ids) { story_ids }
      expect(HackerNewsGateway).to receive(:new) { gateway }
      expect(HackerNewsStory).to receive_message_chain(:where, :includes, :all).and_return([])
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "POST #like" do
    let!(:story) { create(:hacker_news_story) }

    it "creates a Like record" do
      expect { post :like, params: { id: story.id } }.to change { Like.count }.by(1)
    end

    it "redirects to the index" do
      post :like, params: { id: story.id }
      expect(response).to redirect_to(action: :index)
    end
  end
end
