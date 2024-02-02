require 'rails_helper'
require_relative '../helpers/pages_controller_helper_spec'

RSpec.feature 'Home Page', type: :feature do
  include PagesControllerHelper

  scenario 'displays expected elements' do
    user = create_user
    login_as(user, scope: :user)
    visit root_path

    expect(page).to have_link('Home', href: root_path)
    expect(page).to have_link('Starred Stories', href: starred_stories_path)
    expect(page).to have_content("#{user.first_name} #{user.last_name}")
    expect(page).to have_link('Sign Out', href: destroy_user_session_path)
  end
end
