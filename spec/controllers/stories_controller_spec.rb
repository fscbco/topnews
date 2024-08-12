require 'rails_helper'

RSpec.describe StoriesController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let(:story) { create(:story) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    before { get :index }

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'assigns @stories' do
        create_list(:story, 25)
        get :index
        expect(assigns(:stories).count).to eq(20)
    end

    it 'paginates the stories' do
        create_list(:story, 25)
        get :index, params: { page: 2 }
        expect(assigns(:stories).count).to eq(5)
  end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes the Load Latest News button' do
      expect(response.body).to include('Load Latest News')
    end
  end

  describe 'GET #starred' do
    before do
      user.star_story(story)
      get :starred
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'assigns @starred_stories' do
      expect(assigns(:starred_stories)).to include(story)
    end

    it 'renders the starred template' do
      expect(response).to render_template(:starred)
    end
  end

  describe 'POST #star' do
    it 'stars a story' do
      expect {
        post :star, params: { id: story.hacker_news_id }
      }.to change { user.stories.count }.by(1)
    end

    it 'redirects to root path for HTML request' do
      post :star, params: { id: story.hacker_news_id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'DELETE #unstar' do
    before { user.star_story(story) }

    it 'unstars a story' do
      expect {
        delete :unstar, params: { id: story.hacker_news_id }
      }.to change { user.stories.count }.by(-1)
    end

    it 'redirects to root path for HTML request' do
      delete :unstar, params: { id: story.hacker_news_id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #fetch_latest_news' do
    before do
      allow(controller).to receive(:fetch_top_story_ids).and_return([1, 2, 3])
      allow(controller).to receive(:fetch_story_data).and_return({
        'id' => 1,
        'title' => 'Test Story',
        'url' => 'http://example.com',
        'score' => 100,
        'descendants' => 10
      }, {
        'id' => 2,
        'title' => 'Test Story 2',
        'url' => 'http://example.com',
        'score' => 200,
        'descendants' => 20
      }, {
        'id' => 3,
        'title' => 'Test Story 3',
        'url' => 'http://example.com',
        'score' => 300,
        'descendants' => 30
      })
    end
  
    it 'fetches new stories and updates @stories' do
      expect {
        get :fetch_latest_news, xhr: true
      }.to change { Story.count }.by(3)
    end

    it 'assigns @stories with all stories' do
      get :fetch_latest_news, xhr: true
      expect(assigns(:stories).map(&:attributes)).to eq(Story.all.order(created_at: :desc).map(&:attributes))
    end

    it 'renders the stories list partial' do
      get :fetch_latest_news, xhr: true
      expect(response).to render_template(partial: '_stories_list')
    end
  end
end