require 'rails_helper'

RSpec.describe StoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:story) { create(:story) }

  before do
    sign_in user
    allow(HackerNewsService).to receive_message_chain(:new, :fetch_top_stories).and_return([story])
  end

  describe 'before actions' do
    it 'calls #load_stories' do
      expect(controller).to receive(:load_stories)
      get :index
    end

    it 'calls #flagged_stories' do
      expect(controller).to receive(:flagged_stories)
      get :index
    end
  end

  describe 'private methods' do
    it 'correctly sets @stories' do
      get :index
      expect(assigns(:stories)).to include(story)
    end

    it 'correctly sets @flagged_stories' do
      Flag.create(user: user, story: story)
      get :index
      expect(assigns(:flagged_stories)).to eq({ story.id => [Flag.last] })
    end
  end
end
