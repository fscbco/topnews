require 'rails_helper'

def signed_in_user(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end

describe 'The RecommendedFeedsController#home view', type: :feature do
  let!(:user) do
    User.create(first_name: 'Gene', last_name: 'Angelo', email: 'gene@angelo.com', password: 'password')
  end

  context 'when there are no recommended news feeds' do
    before do
      signed_in_user user
      click_link 'Recommended News'
    end

    it "displays 'Nothing too exciting I guess!'" do
      expect(page.current_path).to eq recommended_news_path
      expect(page).to have_content 'Nothing too exciting I guess!'
    end
  end

  context 'when there are news feeds' do
    before do
      VCR.use_cassette('run_pull_feeds_job') do
        PullFeedsJob.new.perform
      end
      user.feeds << Feed.first
      signed_in_user user
      click_link 'Recommended News'
    end

    it "does not display 'Nothing too exciting I guess!'" do
      expect(page.current_path).to eq recommended_news_path
      expect(page).to_not have_content 'Nothing too exciting I guess!'
    end
  end
end
