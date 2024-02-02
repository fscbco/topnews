require 'rails_helper'
require_relative '../helpers/pages_controller_helper_spec'

describe PagesController do 
  include PagesControllerHelper

  describe "GET #home" do
    context 'user successfully authenticated' do
      let(:user) { create_user }

      let(:top_stories) do
        [
          { "title" => "Story 1", "url" => "https://teststories.com/1" },
          { "title" => "Story 2", "url" => "https://teststories.com/2" },
        ]
      end

      before do
        sign_in user
        allow(HackerNews).to receive(:top_stories).and_return(top_stories)
        get :home
      end

      it 'should return a successful response' do
        expect(response).to have_http_status(:success)
      end

      it '@stories is assigned' do
        expect(assigns(:stories)).to be_present
        expect(assigns(:stories)).to eq(top_stories)
      end

      it "renders the home template" do
        expect(response).to render_template(:home)
      end
    end

    context 'user fails authentication' do
      before do
        get :home
      end

      it 'should redirect to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #starred_stories' do
    let(:user) { create_user }

    before do
      sign_in user
    end

    it 'returns stories and users who starred them' do
      story = Story.create(title: 'Test Story', url: 'https://teststories.com', by: 'Jason Ng', score: 33, time: Time.now)
      Star.create(user: user, story: story)

      get :starred_stories

      expect(response).to have_http_status(:success)
      expect(assigns(:starred_stories)).to include(story)
      expect(response).to render_template(:starred_stories)
    end

    # Example with no starred stories
    it 'no starred stories returns an empty Array' do
      get :starred_stories

      expect(response).to have_http_status(:success)
      expect(assigns(:starred_stories)).to be_empty
      expect(response).to render_template(:starred_stories)
    end
  end

  describe 'GET #starred_story_ids' do
    context 'returns starred story IDs' do
      let(:user) { create_user }

      let!(:starred_stories) do
        story1 = Story.create(title: 'Story 1', by: 'Author 1', score: 33, url: 'https://teststories.com/1', time: Time.now)
        story2 = Story.create(title: 'Story 2', by: 'Author 2', score: 66, url: 'https://teststories.com/2', time: Time.now)
      
        Star.create(user: user, story: story1)
        Star.create(user: user, story: story2)

        [story1, story2]
      end

      before do
        sign_in user
        get :starred_story_ids, params: { user_id: user.id }
      end

      it 'returns a JSON response with starred_story_ids' do
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['starred_story_ids'].length).to eq(2)
      end
    end
  end
end