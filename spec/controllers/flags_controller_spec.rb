require 'rails_helper'

RSpec.describe FlagsController, type: :controller do
  let(:user) { create(:user) }
  let(:story) { create(:story, title: 'New Story', url: 'www.example.com') }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with a valid story' do
      it 'does not create a new story if it already exists' do
        expect(story).to be_persisted
        expect {
          post :create, params: { story_id: story.id }
        }.to change(Story, :count).by(0)
      end

      it 'creates a new flag record for the story' do
        expect {
          post :create, params: { story_id: story.id }
        }.to change(Flag, :count).by(1)
      end

      it 'redirects to the stories index page' do
        post :create, params: { story_id: story.id }
        expect(response).to redirect_to(stories_path)
      end

      it 'sets a flash notice on success' do
        post :create, params: { story_id: story.id }
        expect(flash[:notice]).to eq('Story flagged successfully.')
      end
    end

    context 'with an invalid story' do
      it 'does not create a new flag record' do
        expect {
          post :create, params: { story_id: 999000000000000 }
        }.to_not change(Flag, :count)
      end

      it 'redirects to the stories index page with an alert message' do
        post :create, params: { story_id: 999000000000000 }
        expect(response).to redirect_to(stories_path)
        expect(flash[:alert]).to eq('Story not found.')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      current_user = user
      current_user.flagged_stories << story
    end

    it 'removes a flag for the story' do
      expect {
        delete :destroy, params: { story_id: story.id }
      }.to change(Flag, :count).by(-1)
    end

    it 'redirects to the stories index page' do
      delete :destroy, params: { story_id: story.id }
      expect(response).to redirect_to(stories_path)
    end

    it 'sets a flash notice on success' do
      delete :destroy, params: { story_id: story.id }
      expect(flash[:notice]).to eq('Story unflagged successfully.')
    end
  end
end
