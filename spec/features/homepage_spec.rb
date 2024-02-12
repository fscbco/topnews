require "rails_helper"

describe "visiting the app's home page" do
  scenario "without logging in" do
    visit "/"

    expect(page).to have_content("You need to sign in or sign up before continuing")
  end

  scenario "after having logged in" do
    password = "password123"
    email = "user@gmail.com"
    user = User.create!(email: email, password: password)

    visit("users/sign_in")

    fill_in("Email", with: email)
    fill_in("Password", with: password)
    click_button("Log in")

    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Welcome to Top News")
  end
end
