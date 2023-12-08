require 'rails_helper'
RSpec.describe 'Stories API', type: :request do
  describe 'POST /likes' do
    before(:each) do 
      @user = User.create!(first_name: 'test1', last_name: 'test1', email: 'test@test.com', password: 'password')
      @story = Story.create!(title: 'Story-1', url: 'www.test.com', hacker_news_id: 1, top: true) 
      sign_in @user
    end


    it 'should create a like when I post' do
      post '/likes', params: { story_id: @story.id} 

      @story.reload
      expect(@story.likes.sole.user).to eq(@user)
    end

    it "should not allow you to create a second like" do 
      Like.create!(user: @user, story: @story)

      post '/likes', params: { story_id: 0} 

      expect(@story.likes.where(user: @user).count).to eq(1)
      expect(flash[:alert]).to include("story_id: is unrecognized")
    end

    it "should not allow you to create a second like" do 
      Like.create!(user: @user, story: @story)

      post '/likes', params: { story_id: @story.id} 

      expect(@story.likes.where(user: @user).count).to eq(1)
      expect(flash[:alert]).to include("story_id: is a duplicate")
    end


  end
end
