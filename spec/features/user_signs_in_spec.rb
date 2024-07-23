# spec/features/user_signs_in_spec.rb
require 'rails_helper'

RSpec.describe "User signs in", type: :feature do
  scenario "with valid credentials" do
    user = User.create!(email: "test@example.com", password: "password")

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully")
  end

  scenario "with invalid credentials" do
    visit new_user_session_path
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "wrongpassword"
    click_button "Log in"

    expect(page).to have_content("Invalid Email or password")
  end
end