require 'rails_helper'

describe PagesController do 
  describe "GET #home" do
    context 'user successfully authenticated' do
      let(:user) do
        User.create(
          first_name: 'Jason',
          last_name: 'Ng',
          email: 'jason.ng@randomemail.com',
          password: 'abc123'
        )
      end

      let(:top_stories) do
        [
          { "title" => "Story 1", "url" => "https://example.com/story/1" },
          { "title" => "Story 2", "url" => "https://example.com/story2" },
        ]
      end

      before do
        sign_in user
        allow(HackerNews).to receive(:top_stories).and_return(top_stories)
        get :home
      end

      it 'should return a successful response' do
        expect(response).to be_successful
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
end