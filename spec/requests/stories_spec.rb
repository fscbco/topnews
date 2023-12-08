require 'rails_helper'
RSpec.describe 'Stories API', type: :request do
  describe 'GET /' do
    before(:each) do 
      @user = User.create!(first_name: 'test1', last_name: 'test1', email: 'test@test.com', password: 'password')
      @liked_story = Story.create!(title: 'Story-1', url: 'www.test.com', hacker_news_id: 1, top: true) 
      @unliked_story = Story.create!(title: 'Test Story-2', url: 'www.test.com', hacker_news_id: 2, top: true) 
      Like.create!(user: @user, story: @liked_story)
      sign_in @user
    end


    it 'returns only liked stories' do
      get '/', params: { filter: { liked: 'true' } } 
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Story-1")
      expect(response.body).to_not include("Story-2")
    end

    it "returns both liked and unliked stories when not filtering by liked" do
      get '/'
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Story-1")
      expect(response.body).to include("Story-2")
    end

    it "does not return stories that are not top stories" do 
      @liked_story.update!(top: false)
      @unliked_story.update!(top: false)

      get '/'


      expect(response).to have_http_status(:success)
      expect(response.body).to_not include("Story-1")
      expect(response.body).to_not include("Story-2")

    end

    it "displays all names of individuals that liked a story" do 
      user2 = User.create!(first_name: 'test2', last_name: 'test2', email: 'test2@test.com', password: 'password')
      Like.create!(user: user2, story: @liked_story)
      @unliked_story.update!(top: false)

      get '/'

      expect(response).to have_http_status(:success)
      expect(response.body).to include("test1 test1")
      expect(response.body).to include("test2 test2")
    end

    it "should see option to like a story that I haven't liked" do 
      user2 = User.create!(first_name: 'test2', last_name: 'test2', email: 'test2@test.com', password: 'password')
      Like.create!(user: user2, story: @liked_story)
      @unliked_story.update!(top: true)
      @liked_story.update!(top: false)

      get '/'

      expect(response).to have_http_status(:success)
      expect(response.body).to include("Like")
    end

    it 'should display error when invalid pagination param is entered' do
      get '/', params: { page: 'ty' } 

      expect(response.body).to include("page: must be an integer")
      expect(response.body).to_not include("Story-1")
      expect(response.body).to_not include("Story-2")
    end

  end
end
