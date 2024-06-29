# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:story) { create(:story) }
  let(:stories) { create_list(:story, 5) }
  let(:hacker_news_api) { instance_double('HackerNewsApi') }

  before do
    sign_in user
    allow(HackerNewsApi).to receive(:new).and_return(hacker_news_api)
    allow(hacker_news_api).to receive(:fetch_stories).and_return(stories)
  end

  describe 'GET #index' do
    it 'assigns @stories' do
      get :index
      expect(assigns(:stories)).to match_array(stories)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #like' do
    context 'when the story has not been liked by the user' do
      it 'creates a like' do
        expect do
          post :like, params: { id: story.id }
        end.to change(Like, :count).by(1)
      end

      it 'redirects to the stories path for HTML requests' do
        post :like, params: { id: story.id }
        expect(response).to redirect_to(stories_path)
      end

      it 'renders the turbo stream for turbo stream requests' do
        request.env['HTTP_ACCEPT'] = 'text/vnd.turbo-stream.html'
        post :like, params: { id: story.id }
        expect(response.media_type).to eq Mime[:turbo_stream]
      end
    end

    context 'when the story has already been liked by the user' do
      before { create(:like, user:, story:) }

      it 'does not create a like' do
        expect do
          post :like, params: { id: story.id }
        end.not_to change(Like, :count)
      end
    end
  end
end
