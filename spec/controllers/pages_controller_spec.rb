require "rails_helper"
require_relative '../support/devise'

describe PagesController do
    describe '#home' do
        login
        context 'no Feed objects' do
            before(:each) do
                Feed.destroy_all
            end

            it 'creates a new object and assigns it to @latest_feed' do
                expect{ get :index }.to change {Feed.count}.by(1)
                expect(response).to render_template(:index)
                expect(assigns(:latest_feed)).to be_a(Feed)
            end
        end

        context 'the latest Feed object created over 15 minutes ago' do
            before(:each) do
                Feed.destroy_all
                @old_feed = Feed.fetch_and_persist
                @old_feed.created_at = Time.now - 1.hour
                @old_feed.save
            end

            it 'creates a new object and assigns it to @latest_feed' do
                expect{ get :index }.to change {Feed.count}.by(1)
                expect(assigns(:latest_feed)).to_not eq(@old_feed)
            end
        end

        context 'the latest Feed object created under 15 minutes ago' do
            before(:each) do
                Feed.destroy_all
                @new_feed = Feed.fetch_and_persist
            end

            it 'assigns it to @latest_feed' do
                expect{ get :index }.to change {Feed.count}.by(0)
                expect(assigns(:latest_feed)).to eq(@new_feed)
            end
        end
    end
end