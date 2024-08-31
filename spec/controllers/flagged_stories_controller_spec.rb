require "rails_helper"
require_relative '../support/devise'

describe FlaggedStoriesController do
    let(:sample_title){ 'Super slick story' }
    let(:sample_url){ 'https://example.com/story/1/' }
    
    login

    after(:each) do
        expect(response).to redirect_to(root_path)
    end
    
    describe '#add' do
        context 'without existing FlaggedStory' do

            before(:each) do
                FlaggedStory.destroy_all
            end
            
            it 'creates a FlaggedStory and associates the user' do
                expect do
                    post :add, params: {
                        title: sample_title,
                        url: URI::Parser.new.escape(sample_url)
                    }
                end.to change{ FlaggedStory.count }.by(1)
                last_flagged = FlaggedStory.last
                expect(last_flagged.url).to eq(sample_url)
                expect(last_flagged.users).to include(@user)
            end
        end

        context 'with existing FlaggedStory' do
            before(:each) do
                FlaggedStory.destroy_all
                story = FlaggedStory.new
                story.url = sample_url
                story.title = sample_title
                story.users << create(:user)
                story.save
            end

            it 'associates the FlaggedStory with the user' do
                expect do
                    post :add, params: {
                        title: sample_title,
                        url: URI::Parser.new.escape(sample_url)
                    }
                end.to change{ FlaggedStory.count }.by(0)
                last_flagged = FlaggedStory.last
                expect(last_flagged.url).to eq(sample_url)
                expect(last_flagged.users).to include(@user)
            end
        end
    end

    describe '#remove' do
        context 'with the current_user as the only associated user' do
            before(:each) do
                FlaggedStory.destroy_all
                @story = FlaggedStory.new
                @story.url = sample_url
                @story.title = sample_title
                @story.users << @user
                @story.save
            end

            it 'deletes the FlaggedStory' do
                expect do
                    get :remove, params: {id: @story.id}
                end.to change{ FlaggedStory.count }.by(-1)
            end
        end

        context 'with the current_user as one of many associated users' do
            before(:each) do
                FlaggedStory.destroy_all
                @story = FlaggedStory.new
                @story.url = sample_url
                @story.title = sample_title
                @story.users << @user
                @story.users << create(:user)
                @story.save
            end

            it 'removes the user from FlaggedStory.users' do
                expect do
                    get :remove, params: {id: @story.id}
                end.to change{ FlaggedStory.count }.by(0)
                @story.users.reload
                expect(@story.users).to_not include(@user)
            end
        end
    end
end