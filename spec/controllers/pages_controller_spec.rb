require 'rails_helper'

describe PagesController do 
  describe "GET #home" do
    context "fetching top stories" do 
      let(:top_stories) do
        [
          { "title" => "Story 1", "url" => "https://example.com/story/1" },
          { "title" => "Story 2", "url" => "https://example.com/story2" },
        ]
      end

      before do
        allow(HackerNews).to receive(:top_stories).and_return(top_stories)
        get :home
      end

      it "assigns @stories with top stories" do
        expect(assigns(:stories)).to eq(top_stories)
      end

      it "renders the home template" do
        expect(response).to render_template(:home)
      end
    end
  end
end