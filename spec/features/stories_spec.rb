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

  scenario "displaying stars on a story" do
    js_story = Story.create!(title: "Has JavaScript surpassed Rust in performance?", author: "BEich91", external_id: "a1")
    user1 = User.create!(email: "user1@gmail.com", password: "password123")
    user2 = User.create!(email: "user2@gmail.com", password: "password123")
    StoryStar.create!(user: user1, story: js_story)
    StoryStar.create!(user: user2, story: js_story)

    log_in(user1)

    visit("/")

    js_story_row = find("tr", text: js_story.title)

    expect(js_story_row).to have_content(user1.email)
    expect(js_story_row).to have_content(user2.email)
  end
end
