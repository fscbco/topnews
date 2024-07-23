require 'rails_helper'

RSpec.describe "Stories", type: :request do
  describe "GET /index" do
    context "when signed in" do
      it "returns http success" do
        user = FactoryBot.create(:user)
        sign_in user
        get "/"
        expect(response).to have_http_status(:success)
      end
    end

    context "when not signed in" do
      it "redirects to sign in page" do
        get "/"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
