require 'rails_helper'

RSpec.describe StoriesController, type: :controller do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }

  before { sign_in user }

  describe 'GET index' do
    it 'fetches top stories and assigns current user starred stories' do
      allow_any_instance_of(HackerNewsService).to receive(:fetch_top_stories).and_return([{ id: 1, title: 'Story 1', url: 'http://story1.com' }])
      story = Story.create(hacker_news_id: 1, title: 'Story 1', url: 'http://story1.com')
      user.stars.create(story: story)

      get :index

      expect(response).to be_successful
      expect(assigns(:stories)).to eq([{ id: 1, title: 'Story 1', url: 'http://story1.com' }])
      expect(assigns(:current_user_starred_stories)).to include(story)
    end
  end

  describe 'GET starred' do
    it 'assigns @starred_stories' do
      story = Story.create(hacker_news_id: 1, title: 'Story 1', url: 'http://story1.com')
      user.stars.create(story: story)

      get :starred

      expect(assigns(:starred_stories)).to include(story)
    end
  end

  describe 'POST star' do
    it 'creates a star for the current user' do
      expect {
        post :star, params: { hacker_news_id: 1, title: 'Story 1', url: 'http://story1.com' }
      }.to change(user.stars, :count).by(1)

      expect(response).to redirect_to(root_path)
    end
  end

  describe 'DELETE star' do
    it 'removes the star for the current user' do
      story = Story.create(hacker_news_id: 1, title: 'Story 1', url: 'http://story1.com')
      user.stars.create(story: story)

      expect {
        delete :unstar, params: { hacker_news_id: story.hacker_news_id }
      }.to change(user.stars, :count).by(-1)

      expect(response).to redirect_to(root_path)
    end
  end
end