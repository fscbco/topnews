require "rails_helper"

describe "stories" do
  scenario "visiting the stories index displays all stories" do
    user = User.create!(email: "user@gmail.com", password: "password123")
    log_in(user)

    js_story = Story.create!(title: "Has JavaScript surpassed Rust in performance?", author: "BEich91", external_id: "a1", url: "foo.com")
    meta_story = Story.create!(title: "Metaverse future is now", author: "mzuck91", external_id: "a2", url: "bar.com")

    visit("/")

    expect(page).to have_content(js_story.title)
    expect(page).to have_content(meta_story.title)
  end

  scenario "starring a story" do
    js_story = Story.create!(title: "Has JavaScript surpassed Rust in performance?", author: "BEich91", external_id: "a1", url: "foo.com")
    user1 = User.create!(first_name: "george", email: "user1@gmail.com", password: "password123")

    log_in(user1)

    visit("/")

    js_story_row = find("#all-news tr", text: js_story.title)

    expect(js_story_row).not_to have_content(user1.email)

    js_story_row.click_on("Star")

    js_story_row = find("#top-news tr", text: js_story.title)

    expect(page).to have_content("Story successfully starred!")
    expect(js_story_row).to have_content(user1.first_name)
    expect(js_story_row).not_to have_button("Star")
  end

  scenario "displaying stars on a story" do
    js_story = Story.create!(title: "Has JavaScript surpassed Rust in performance?", author: "BEich91", external_id: "a1", url: "foo.com")
    user1 = User.create!(first_name: "john", email: "user1@gmail.com", password: "password123")
    user2 = User.create!(first_name: "ringo", email: "user2@gmail.com", password: "password123")
    StoryStar.create!(user: user1, story: js_story)
    StoryStar.create!(user: user2, story: js_story)

    log_in(user1)

    visit("/")

    js_story_row = find("#top-news tr", text: js_story.title)

    expect(js_story_row).to have_content(user1.first_name)
    expect(js_story_row).to have_content(user2.first_name)
  end
end
