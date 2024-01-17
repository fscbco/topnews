require 'rails_helper'

RSpec.describe "UserStories", type: :request do
  describe "GET /index" do
    it "does not render a different template" do
      user = build(:user)
      sign_in user
      get "/user_stories"
      expect(response).to render_template(:index)
    end
  end
end
