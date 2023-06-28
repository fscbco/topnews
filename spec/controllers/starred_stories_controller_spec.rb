require 'rails_helper'

RSpec.describe StarredStoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:story) { create(:story) }

  before { sign_in(user) }

  describe '#create' do
    it 'creates a new StarredStory' do
      post :create, params: { story_id: story.id }
      expect(StarredStory.count).to eq(1)
      expect(StarredStory.first.user).to eq(user)
      expect(StarredStory.first.story).to eq(story)
    end

    it 'redirects to the root path' do
      post :create, params: { story_id: story.id }
      expect(response).to redirect_to(root_path)
    end

    it 'sets a flash notice message' do
      post :create, params: { story_id: story.id }
      expect(flash[:notice]).to eq("You've starred this story.")
    end
  end
end
