require 'rails_helper'

RSpec.describe 'Stories', type: :request do
  describe 'GET /index' do
    pending 'returns http success' do
      get '/stories/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /like' do
    pending 'returns http success' do
      get '/stories/like'
      expect(response).to have_http_status(:success)
    end
  end
end
