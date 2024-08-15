require 'rails_helper'

RSpec.describe "Applications", type: :request do
  describe "visits any route" do
    context 'without sign in user' do
      it 'redirects to sign in page' do
        get "/"
        expect(response).to redirect_to(:new_user_session)

        follow_redirect!

        expect(response.body).to include("You need to sign in or sign up before continuing")
        expect(response.body).to include("Log in")
        expect(response.body).to include("Email")
        expect(response.body).to include("Password")
        expect(response.body).to include("Remember me")
      end
    end

    context 'with sign in user' do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it 'renders the requested page' do
        get "/"

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("You're logged in!")
        expect(response.body).to include(user.first_name)
        expect(response.body).to include(user.last_name)
        expect(response.body).to include("Welcome to Top News")
        expect(response.body).to include("Log out")
      end
    end
  end
end
