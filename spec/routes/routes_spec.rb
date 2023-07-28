require 'rails_helper'

RSpec.describe 'Routes', type: :routing do
  describe 'PagesController' do
    it 'routes GET / to pages#home' do
      expect(get: '/').to route_to('pages#home')
    end
  end

  describe 'StarredStoriesController' do
    it 'routes GET /starred_stories to starred_stories#index' do
      expect(get: '/starred_stories').to route_to('starred_stories#index')
    end

    it 'routes POST /starred_stories to starred_stories#create' do
      expect(post: '/starred_stories').to route_to('starred_stories#create')
    end
  end

  describe 'Devise routes' do
    it 'routes POST /users/sign_in to devise/sessions#create' do
      expect(post: '/users/sign_in').to route_to('devise/sessions#create')
    end

    it 'routes DELETE /users/sign_out to devise/sessions#destroy' do
      expect(delete: '/users/sign_out').to route_to('devise/sessions#destroy')
    end

    # Add more Devise routes as needed
  end
end
