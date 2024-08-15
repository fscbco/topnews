require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create!(email: "tester@testing.com", password: "no9dkj3kjjsk") }
  let(:story) { Story.create }

  before do
    sign_in(user, scope: :user)
  end

  describe "POST create" do
    it "creates a new recommendation for the story" do
      expect {
        post :create, params: { story_id: story.id }
      }.to change(Recommendation, :count).by(1)
    end

    it "redirects to the stories view url after creating a recommendation" do
      post :create, params: { story_id: story.id }
      expect(response).to redirect_to(stories_view_url)
    end
  end

  describe "DELETE destroy" do
    before do
      Recommendation.create(story_id: story.id, user_id: user.id)
    end

    it "destroys the recommendation for the story" do
      expect {
        delete :destroy, params: { story_id: story.id }
      }.to change(Recommendation, :count).by(-1)
    end

    it "redirects to the stories view url after destroying a recommendation" do
      delete :destroy, params: { story_id: story.id }
      expect(response).to redirect_to(stories_view_url)
    end
  end
end
