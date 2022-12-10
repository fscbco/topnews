require 'rails_helper'

describe 'StarsController', type: :request do
  let(:user) { create(:user) }
  let(:post_obj) { create(:post) }
  let(:star) { create(:star, user: user, post: post_obj) }

  describe '#create' do
    context 'when a user is signed in' do
      before { sign_in user }

      it 'creates a Star' do
        expect { post stars_path(post_id: post_obj.id) }.to change(Star, :count).by(1)
      end

      it 'creates a Star with the correct attributes' do
        post stars_path(post_id: post_obj.id)
        star = Star.last
        expect(star.user_id).to eq user.id
        expect(star.post_id).to eq post_obj.id
      end

      it 'redirects to root_path' do
        post stars_path(post_id: post_obj.id)
        expect(response).to redirect_to root_path
      end

      it 'returns a notice' do
        post stars_path(post_id: post_obj.id)
        follow_redirect!
        notice = 'Star created successfully!'
        expect(response.body).to include notice
      end

      context 'when there is an error' do
        before { star } # Star will exist causing an error around uniquness

        it 'does not create a Star record' do
          expect { post stars_path(post_id: post_obj.id) }.not_to change(Star, :count)
        end

        it 'displays an alert' do
          post stars_path(post_id: post_obj.id)
          follow_redirect!
          alert = 'User has already been taken'
          expect(response.body).to include alert
        end
      end
    end

    context 'when a user is not signed in' do
      it 'redirects to sign in' do
        post stars_path(post_id: post_obj.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    context 'when a user is signed in' do
      before do
        sign_in user
        star
      end

      it 'destroys a Star' do
        expect { delete star_path(id: star.id) }.to change(Star, :count).by(-1)
      end

      it 'redirects to root_path' do
        delete star_path(id: star.id)
        expect(response).to redirect_to root_path
      end

      it 'returns a notice' do
        delete star_path(id: star.id)
        follow_redirect!
        notice = 'Star destroyed successfully!'
        expect(response.body).to include notice
      end

      context 'when the Star does not belong to the User' do
        let(:other_users_star) { create(:star, post: post_obj) }

        before { other_users_star } # other_users_star does not belong to user

        it 'raises an error' do
          expect { delete star_path(id: other_users_star.id) }.to raise_error(StandardError, 'Star not found!')
        end
      end
    end

    context 'when a user is not signed in' do
      it 'redirects to sign in' do
        delete star_path(id: star.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
