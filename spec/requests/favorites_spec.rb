require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  describe "GET /users/1/favorites/create" do
    before(:all) do
      DatabaseCleaner.clean_with(:truncation)
      user1 = create(:user)
      sign_in(user1)
    end
    it "returns http success" do
      post "/users/1/favorites", xhr: true
      expect(response).to redirect_to("/")
    end
  end

end
