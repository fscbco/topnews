require 'rails_helper'

def signed_in_user(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end

describe 'The PagesController#home view', type: :feature do
  let!(:user) do
    User.create(first_name: 'Gene', last_name: 'Angelo', email: 'gene@angelo.com', password: 'password')
  end

  context 'when there are no news feeds' do
    before do
      signed_in_user user
    end

    it "displays 'No news is good news!'" do
      expect(page.current_path).to eq root_path
      expect(page).to have_content 'No news is good news!'
    end
  end

  context 'when there are news feeds' do
    before do
      VCR.use_cassette('run_pull_feeds_job') do
        PullFeedsJob.new.perform
      end
      signed_in_user user
    end

    it "does not display 'No news is good news!'" do
      expect(page.current_path).to eq root_path
      expect(page).to_not have_content 'No news is good news!'
    end
  end
end
