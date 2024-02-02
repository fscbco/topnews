require 'rails_helper'
require_relative '../helpers/pages_controller_helper_spec'

RSpec.feature 'Starred Stories Page', type: :feature do
  include PagesControllerHelper

  scenario 'displays the list of starred stories' do
    user = create_user

    starred_story_1 = Story.create(
      title: 'Story 1',
      by: 'Author 1',
      score: 33,
      url: 'https://random.com/1',
      time: Time.now
    )

    starred_story_2 = Story.create(
        title: 'Story 2',
        by: 'Author 2',
        score: 66,
        url: 'https://random.com/2',
        time: Time.now
      )

    Star.create(user: user, story: starred_story_1)
    Star.create(user: user, story: starred_story_2)

    login_as(user, scope: :user)
    visit starred_stories_path

    expect(page).to have_content('Starred HackerNews Stories')
    expect(page).to have_link(starred_story_2.title, href: starred_story_2.url)
    expect(page).to have_content("By: #{starred_story_2.by} | Score: #{starred_story_2.score}")
    expect(page).to have_selector('.starring-users', text: "#{user.first_name} #{user.last_name}")
  end
end
