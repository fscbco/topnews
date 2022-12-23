require 'rails_helper'

def signed_in_user(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end

describe 'HomeController', type: :feature do
  let!(:user) do
    User.create(first_name: 'Gene', last_name: 'Angelo', email: 'gene@angelo.com', password: 'password')
  end

  context 'when there are no news feeds' do
    before do
      allow_any_instance_of(HomeController).to receive(:poll_feeds_job?).and_return(false)
      signed_in_user user
    end

    it "displays 'No news is good news!'" do
      expect(page.current_path).to eq root_path
      expect(page).to have_content 'No news is good news!'
    end
  end

  context 'when there are news feeds' do
    it "does not display 'No news is good news!'" do
      VCR.use_cassette('top_news_service') do
        PullFeedsJob.new.perform
        expect(Feed.any?).to eq true
        signed_in_user user
        expect(page.current_path).to eq root_path
        expect(page).to_not have_content 'No news is good news!'
      end
    end
  end
end
