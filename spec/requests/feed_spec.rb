require "rails_helper"

RSpec.describe "Feed", type: :request, vcr: true do
  describe "GET /index" do
    it "returns a 200 when the user is logged in" do
      user = User.create!(first_name: "John", last_name: "Smith", email: "hi@gmail.com", password: "password")
      sign_in(user)

      get feed_index_path
      expect(response).to have_http_status(200)
    end

    it "returns a redirect when the user is not logged in" do
      get feed_index_path
      expect(response).to have_http_status(302)
    end
  end
end
