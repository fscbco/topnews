require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  describe "POST /favorite" do
    # TODO: check auth'd requests
    context "when not logged in" do
      it "returns redirects to sign in" do
        post "/favorite"
        expect(response).to redirect_to(new_user_session_path)
      end

      it "redirects to sign in when NOT passed expected params" do
        post "/favorite", params: { foo: :bar }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
