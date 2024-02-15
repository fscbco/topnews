require 'rails_helper'

RSpec.describe "pages/home", type: :view do
  context "when user is signed in" do
    before do
      assign(:user, User.new(first_name: "John", last_name: "Doe"))
      allow(view).to receive(:user_signed_in?).and_return(true)
    end

    it "displays the top news heading" do
      render
      expect(rendered).to have_selector("h1", text: "Top News of the Day")
    end

    it "displays the user's full name" do
      render
      expect(rendered).to have_content("Hi, John Doe!")
    end

    it "renders a link to stories" do
      render
      expect(rendered).to have_link("Stories", href: stories_path)
    end

    it "renders a sign out button" do
      render
      expect(rendered).to have_button("Sign out")
    end
  end

  context "when user is not signed in" do
    before do
      allow(view).to receive(:user_signed_in?).and_return(false)
    end

    it "displays the welcome heading" do
      render
      expect(rendered).to have_selector("h1", text: "Welcome to Top News")
    end

    it "renders a link to sign in" do
      render
      expect(rendered).to have_link("Sign in", href: new_user_session_path)
    end
  end
end