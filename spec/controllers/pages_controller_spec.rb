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
      let(:stories) { top_story_ids.map { |id| build(:story, hacker_news_id: id) } }

      before do
        sign_in user
        allow(HackerNews).to receive(:new).and_return(hacker_news)
        allow(hacker_news).to receive(:top_stories).and_return(top_story_ids)
        allow(Story).to receive(:find_or_create_by_hacker_news_ids).and_return(stories)
      end

      it "returns a successful response" do
        get :home
        expect(response).to be_successful
      end

      it "assigns @top_stories with 10 items" do
        get :home
        expect(assigns(:top_stories).length).to eq(10)
      end

      it "fetches top story ids from HackerNews" do
        expect(hacker_news).to receive(:top_stories)
        get :home
      end

      it "calls find_or_create_by_hacker_news_ids on Story with top story ids" do
        expect(Story).to receive(:find_or_create_by_hacker_news_ids).with(top_story_ids)
        get :home
      end
    end
  end

  describe "GET #recommendations" do
    context "when user is not authenticated" do
      it "redirects to the login page" do
        get :recommendations
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated" do
      let(:user) { create(:user) }
      let!(:stories) do
        10.times.map do |i|
          create(:story).tap do |story|
            create(:recommendation, story: story, created_at: i.days.ago)
          end
        end
      end

      before do
        sign_in user
      end

      it "returns a successful response" do
        get :recommendations
        expect(response).to be_successful
      end

      it "assigns @recent_stories with 10 items" do
        get :recommendations
        expect(assigns(:recent_stories).length).to eq(10)
      end

      it "orders stories by latest recommendation" do
        get :recommendations
        expect(assigns(:recent_stories).to_a).to eq(stories.sort_by { |s| s.recommendations.maximum(:created_at) }.reverse)
      end

      it "limits the result to 10 stories" do
        create_list(:story, 5) do |story|
          create(:recommendation, story: story, created_at: 1.minute.ago)
        end
        get :recommendations
        expect(assigns(:recent_stories).length).to eq(10)
      end
    end
  end
end
