# spec/features/user_signs_in_spec.rb
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe "User signs in", type: :feature do
  before do
    # Stub the request to fetch top stories
    stub_request(:get, "https://hacker-news.firebaseio.com/v0/topstories.json")
      .to_return(body: "[8863, 8864, 8865]", headers: { 'Content-Type' => 'application/json' })

    # Stub the request to fetch story details for each story
    [8863, 8864, 8865].each do |story_id|
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/#{story_id}.json")
        .to_return(body: {
          id: story_id,
          title: "Story #{story_id}",
          url: "http://example.com/#{story_id}",
          by: "author#{story_id}",
          score: 100 + story_id,
          time: 1175714200,
          descendants: 50 + story_id,
          type: "story"
        }.to_json, headers: { 'Content-Type' => 'application/json' })
    end
  end

  scenario "with valid credentials" do
    user = FactoryBot.create(:user)

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