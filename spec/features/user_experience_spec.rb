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

  scenario "User signs in" do
    expect(page).to have_content("Signed in successfully.")
  end

  scenario "User can star stories" do
    within("#story_#{story['id']}") do
      click_button "Star"
    end
    expect(page).to have_content("You've starred this story.")
    visit starred_stories_path
    expect(page).to have_content("Starred by #{user.id}")
  end

end
