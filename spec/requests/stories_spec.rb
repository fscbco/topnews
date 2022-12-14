# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stories', type: :request do
  describe 'GET /index' do
    it 'renders the index template' do
      user = User.create!(email: 'bob.jones@example.com', password: 'password420')
      sign_in user
      get stories_path
      expect(response).to render_template(:index)
    end
  end
end
