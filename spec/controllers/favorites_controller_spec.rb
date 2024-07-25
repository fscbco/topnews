require 'rails_helper'

RSpec.describe FavoritesController, type: :request do
    let(:user) { create(:user) }
    let(:story) { create(:story) }

    shared_examples 'a redirect to login' do
        it 'redirects to login page' do
            subject

            expect(response).to redirect_to(new_user_session_path)
            expect(response.status).to eq(302)
        end
    end

    describe 'POST #create' do
        subject { post path, params: params  }
        let(:path) { '/favorite' }
        let(:params) { {story_id: story.id} }

        before do
            sign_in(user)
        end

        it 'favorites a story for a user' do
            expect { subject }.to change { Favorite.count }.by(1)
        end

        it 'redirects to home page' do
            subject
            expect(response).to redirect_to(root_path)
            expect(response.status).to eq(302)
        end 

        context 'when there is no user signed in' do
            before do
                sign_out(user)
            end

            it_behaves_like 'a redirect to login'
        end

        context 'when a user already favored a story' do
            before do
                Favorite.create!(story_id: story.id, user_id: user.id)
            end

            it 'does not create another favorite record' do
                expect { subject }.not_to change { Favorite.count }
            end
        end
    end

    describe 'DELETE #destroy' do
        subject { delete path, params: params  }
        let(:path) { '/favorite' }
        let(:params) { {story_id: story.id} }

        before do
            sign_in(user)
            Favorite.create!(story_id: story.id, user_id: user.id)
        end

        it 'deletes a favorite association for a user and a story' do
            expect { subject }.to change { Favorite.count }.by(-1)
        end

        it 'redirects to home page' do
            subject
            expect(response).to redirect_to(root_path)
            expect(response.status).to eq(302)
        end 

        context 'when there is no user signed in' do
            before do
                sign_out(user)
            end

            it_behaves_like 'a redirect to login'
        end

        context 'when the user never had a favored association to the story' do
            let(:params) { {story_id: 'unknown_id'} }
            before do
                Favorite.create!(story_id: story.id, user_id: user.id)
            end

            it 'does not delete a favorite record' do
                expect { subject }.not_to change { Favorite.count }
            end
        end
    end
end