require 'rails_helper'

RSpec.describe "Stories", type: :request do
  describe 'GET /index' do
    let(:user) { create(:user) }

    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'returns http success' do
        get stories_path(user)
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get user_favorites_path(user)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
