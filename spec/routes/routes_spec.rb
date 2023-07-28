require 'rails_helper'

RSpec.describe 'Routes', type: :routing do
  describe 'PagesController' do

    it 'routes GET / to stories#starred' do
      expect(get: '/').to route_to('stories#starred')
    end
  end

  describe 'StarredStoriesController' do
    it 'routes GET /stories to stories#index' do
      expect(get: '/stories').to route_to('stories#index')
    end

    it 'routes POST /stories to starred_stories#create' do
      expect(post: '/stories').to route_to('stories#create')
    end
  end

  describe 'Devise routes' do
    it 'routes POST /users/sign_in to devise/sessions#create' do
      expect(post: '/users/sign_in').to route_to('devise/sessions#create')
    end

    it 'routes GET /logout to devise/sessions#destroy' do
      expect(get: '/logout').to route_to('devise/sessions#destroy')
    end

    # Add more Devise routes as needed
  end
end
