require "rails_helper"

describe "stories" do
  scenario "visiting the stories index displays all stories" do
    user = User.create!(email: "user@gmail.com", password: "password123")
    log_in(user)

    js_story = Story.create!(title: "Has JavaScript surpassed Rust in performance?", author: "BEich91", external_id: "a1")
    meta_story = Story.create!(title: "Metaverse future is now", author: "mzuck91", external_id: "a2")

    visit("/")

    expect(page).to have_content(js_story.title)
    expect(page).to have_content(meta_story.title)
  end
end
