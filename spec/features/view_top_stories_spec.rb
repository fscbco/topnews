require 'rails_helper'

RSpec.feature "View top stories", type: :feature do
  let(:user) { create(:user) }

  before do
    stub_request(:get, "https://hacker-news.firebaseio.com/v0/topstories.json")
      .to_return(body: Rails.root.join("spec", "fixtures", "topstories.json"), status: 200)
    stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/1.json")
      .to_return(body: Rails.root.join("spec", "fixtures", "item-1.json"), status: 200)
    stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/2.json")
      .to_return(body: Rails.root.join("spec", "fixtures", "item-2.json"), status: 200)
  end


  scenario "when logged out" do
    visit "/stories"
    expect(page).to have_text("Log in")
  end

  scenario "when logged in" do
    sign_in(user)
    visit "/stories"
    expect(page).to have_text("Welcome to Top News")
    expect(page).to have_text("Vector Databases: A Technical Primer")
    expect(page).to have_text("I'm sorry but I cannot fulfill this request it goes against OpenAI use policy")
  end
end
