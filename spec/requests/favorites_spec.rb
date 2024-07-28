# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
  describe 'POST /create' do
    let(:user) { create(:user) }
    let(:db_post) { create(:post) }

    subject(:creation) do
      post favorites_path(post_id: db_post.id)
    end

    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'creates a favorite' do
        expect { creation }.to change(Favorite, :count).by(1)
        # falling back to root_path because we don't have a referer set in the test
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is not logged in' do
      it 'does not create a favorite' do
        expect { creation }.not_to change(Favorite, :count)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /index' do
    let(:user) { create(:user) }

    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'returns http success' do
        get user_favorites_path(user)
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
