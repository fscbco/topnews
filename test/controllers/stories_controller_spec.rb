require 'rails_helper'

RSpec.describe StoriesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create(email: 'test@example.com', password: 'correct horse battery staple') }

  before do
    sign_in(user, scope: :user)
  end

  describe 'GET #view' do
    it 'assigns top stories to @stories' do
      story1 = Story.new(title: 'Story 1')
      story2 = Story.new(title: 'Story 2')

      StoryRanking.new(story: story1, rank: 2)
      StoryRanking.new(story: story2, rank: 1)

      allow(StoryRanking).to receive(:top_stories).and_return([story2, story1])

      get :view

      expect(response).to have_http_status(:success)
      stories = controller.instance_variable_get(:@stories)
      expect(stories).to match_array([story2, story1])
    end
  end

  describe 'GET #recommendations' do
    it 'assigns recommended stories to @stories' do
      story1 = Story.new(title: 'Story 3')
      story2 = Story.new(title: 'Story 4')

      allow(Recommendation).to receive(:stories).and_return([story1, story2])

      get :recommendations
      stories = controller.instance_variable_get(:@stories)
      expect(stories).to match_array([story2, story1])
    end
  end
end
