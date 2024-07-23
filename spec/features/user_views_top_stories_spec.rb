# spec/features/user_views_top_stories_spec.rb
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe "User views top stories", type: :feature do
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

  scenario "user sees a list of top stories" do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)

    visit top_stories_path

    expect(page).to have_content("Story 8863")
    expect(page).to have_content("Story 8864")
    expect(page).to have_content("Story 8865")
  end
end