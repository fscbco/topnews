require 'rails_helper'

RSpec.describe "Stories", type: :request do
  describe "GET /index" do
    let(:user) { FactoryBot.create(:user) }

    before do
      sign_in user
    end

    it "returns http success" do
      get "/stories"
      expect(response).to have_http_status(:success)
    end
  end
end
