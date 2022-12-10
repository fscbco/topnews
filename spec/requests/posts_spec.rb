require 'rails_helper'

describe 'PostsController', type: :request do
  describe '#index' do
    context 'when a user is signed in' do
      let(:user) { create(:user) }

      before { sign_in user }

      it 'renders the page' do
        get posts_path
        expect(response).to be_successful
      end

     it 'renders posts' do
       existing_post = create(:post)
       get posts_path

       expect(response.body).to include existing_post.title
      end

     context 'when filter params is starred' do
       it 'returns starred posts' do
         starred_post = create(:post, :with_stars)
         get posts_path(filter: 'starred')
         expect(response.body).to include starred_post.title
       end

       it 'does not return posts that are not starred' do
         starred_post = create(:post, :with_stars)
         unstarred_post = create(:post)
         get posts_path(filter: 'starred')
         expect(response.body).not_to include unstarred_post.title
       end
     end
    end

    context 'when a user is not signed in' do
      it 'redirects to sign in' do
        get posts_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
