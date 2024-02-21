require "rails_helper"

RSpec.describe "Likes", type: :request do
  describe "Post /create" do
    it "creates a like when the user is signed in and redirects to the feed_index_path as a fallback" do
      user = User.create!(first_name: "John", last_name: "Smith", email: "hi@gmail.com", password: "password")
      story = Story.create!(hacker_news_id: 1234, raw_data: {})

      sign_in(user)

      expect {
        post likes_path, params: {story_id: story.id}
      }.to change(user.likes.where(story_id: story.id), :count).by(1)

      expect(response.status).to eq(302)
      expect(response).to redirect_to(feed_index_path)
    end

    it "creates a like when the user is signed in and redirects to the referrer" do
      user = User.create!(first_name: "John", last_name: "Smith", email: "hi@gmail.com", password: "password")
      story = Story.create!(hacker_news_id: 1234, raw_data: {})

      sign_in(user)

      expect {
        post likes_path, params: {story_id: story.id}, headers: {"HTTP_REFERER" => liked_stories_path}
      }.to change(user.likes.where(story_id: story.id), :count).by(1)

      expect(response.status).to eq(302)
      expect(response).to redirect_to(liked_stories_path)
    end

    it "will not allow a like to be created if the user is not logged in" do
      story = Story.create!(hacker_news_id: 1234, raw_data: {})

      expect {
        post likes_path, params: {story_id: story.id}
      }.to_not change(Like, :count)
      expect(response.status).to eq(302)
    end
  end
end
