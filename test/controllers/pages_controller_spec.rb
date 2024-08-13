require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET #home" do
    context "when user is signed in" do
      before { allow(controller).to receive(:user_signed_in?).and_return(true) }

      it "redirects to stories_view_url" do
        get :home
        expect(response).to redirect_to(stories_view_url)
      end
    end

    context "when user is not signed in" do
      before { allow(controller).to receive(:user_signed_in?).and_return(false) }

      it "does not redirect" do
        get :home
        expect(response).not_to have_http_status(:redirect)
      end
    end
  end
end
