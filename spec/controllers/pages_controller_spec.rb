require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET #home" do
    context "when user is not authenticated" do
      it "redirects to the login page" do
        get :home
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated" do
      let(:user) { create(:user) }
      let(:hacker_news) { instance_double(HackerNews) }
      let(:top_story_ids) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }
      let(:story) { { "title" => "Test Story", "url" => "http://example.com" } }

      before do
        sign_in user
        allow(HackerNews).to receive(:new).and_return(hacker_news)
        allow(hacker_news).to receive(:top_stories).and_return(top_story_ids)
        allow(hacker_news).to receive(:item).and_return(story)
      end

      it "returns a successful response" do
        get :home
        expect(response).to be_successful
      end

      it "assigns @top_stories with 10 items" do
        get :home
        expect(assigns(:top_stories).length).to eq(10)
      end

      it "fetches top stories from HackerNews" do
        expect(hacker_news).to receive(:top_stories)
        expect(hacker_news).to receive(:item).exactly(10).times
        get :home
      end
    end
  end
end
