require "rails_helper"

RSpec.describe "LikedStories", type: :request, vcr: true do
  describe "GET /index" do
    it "returns a redirect when the user is not logged in" do
      user = User.create!(first_name: "John", last_name: "Smith", email: "hi@gmail.com", password: "password")
      create_data(user: user)

      get liked_stories_path
      expect(response.status).to eq(302)
    end

    it "returns a 200 when the user is logged in" do
      user = User.create!(first_name: "John", last_name: "Smith", email: "hi@gmail.com", password: "password")
      sign_in(user)

      create_data(user: user)

      get liked_stories_path
      expect(response.status).to eq(200)
    end
  end

  private

  def create_data(user:)
    ids = FetchTopStoriesFromApiService.new(limit: 10).call

    ids.each do |id|
      FindOrCreateStoryService.new(id: id).call
    end

    expect(Story.count).to eq(10)
    Story.all.sample(2).each do |story|
      Like.create!(user_id: user.id, story_id: story.id)
    end
  end
end
