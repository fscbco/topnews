require 'rails_helper'

FactoryBot.define do
  factory :user do
    email { "user_#{rand(999999).to_s}@example.org" }
    password { 'eeMaev2shai'}
  end
end

RSpec.feature "User Experience", type: :feature do
  let(:user) {create(:user)}
  let(:story) { HackerNewsService.new.top_stories.first }


  before(:each) do
    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  scenario "User can login" do
    expect(page).to have_content(user.email)
    expect(page).to have_content("Logout")
  end

  scenario "User can logout" do
    expect(page).to have_content(user.email)
    click_on "Logout"
    expect(page).not_to have_content(user.email)
  end
end
