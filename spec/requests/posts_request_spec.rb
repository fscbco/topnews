require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "POST /posts" do
    let(:user) {User.create!(email: "test@example.com", password: "123123")}

    it "creates a new post" do
      post_params = {
        title: "This is the title of the new post.",
        url: "http://www.example.com",
        item_id: 12345
      }
      sign_in user

      expect {
        post "/posts", params: post_params
      }.to change(Post, :count).by(1)

      expect(response).to have_http_status(302)
    end
  end
end