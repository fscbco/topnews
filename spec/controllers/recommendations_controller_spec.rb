require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  let(:user) { create(:user) }
  let(:story) { create(:story) }

  describe 'POST #create' do
    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        post :create, params: { story_id: story.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authenticated' do
      before do
        sign_in user
      end

      context 'when save succeeds' do
        it 'creates a new recommendation' do
          expect {
            post :create, params: { story_id: story.id }
          }.to change(Recommendation, :count).by(1)
        end

        it 'associates the recommendation with the current user' do
          post :create, params: { story_id: story.id }
          expect(Recommendation.last.user).to eq(user)
        end

        it 'associates the recommendation with the correct story' do
          post :create, params: { story_id: story.id }
          expect(Recommendation.last.story).to eq(story)
        end

        it 'redirects back with a success notice' do
          post :create, params: { story_id: story.id }
          expect(response).to redirect_to(root_path)
          expect(flash[:notice]).to eq('Story recommended successfully!')
        end
      end

      context 'when save fails' do
        before do
          allow_any_instance_of(Recommendation).to receive(:save).and_return(false)
        end

        it 'does not create a new recommendation' do
          expect {
            post :create, params: { story_id: story.id }
          }.not_to change(Recommendation, :count)
        end

        it 'redirects back with an alert' do
          post :create, params: { story_id: story.id }
          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eq('Unable to recommend the story.')
        end
      end
    end
  end
end
