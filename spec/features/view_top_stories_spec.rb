require 'rails_helper'

RSpec.feature "View top stories", type: :feature do
  let(:user) { create(:user) }

  scenario "when logged out" do
    visit "/stories"
    expect(page).to have_text("Log in")
  end

  scenario "when logged in" do
    sign_in(user)
    visit "/stories"
    expect(page).to have_text("Welcome to Top News")
    expect(page).to have_text("Vcc – The Vulkan Clang Compiler")
    expect(page).to have_text("Wikihouse: Open-Source Houses")
  end
end
