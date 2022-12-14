# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stars', type: :request do
  describe 'POST /create' do
    it 'creates a new Star' do
      story = Story.create!(hacker_news_id: 1, by: 'test', published_at: Time.now, title: 'test', link: 'test')
      user = User.create!(email: 'bob.jones@example.com', password: 'password420')

      sign_in user
      post story_stars_path(story)
      expect(response).to redirect_to(stories_path)
    end
  end
end
