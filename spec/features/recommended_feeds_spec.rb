require 'rails_helper'

def signed_in_user(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end

describe 'RecommendedFeedsController', type: :feature do
  let!(:user) do
    User.create(first_name: 'Gene', last_name: 'Angelo', email: 'gene@angelo.com', password: 'password')
  end

  context 'when there are no feeds in the feeds table' do
    before do
      signed_in_user user
    end

    it 'redirects to the poll_feeds_path' do
      expect(page.current_path).to eq poll_feeds_path
    end
  end

  context 'when there are no recommended news feeds' do
    it "displays 'Nothing too exciting I guess!'" do
      VCR.use_cassette('top_news_service') do
        PullFeedsJob.new.perform
        signed_in_user user
        expect(page.current_path).to eq root_path
        click_link 'Recommended News'
        expect(page.current_path).to eq recommended_news_path
        expect(page).to have_content 'Nothing too exciting I guess!'
      end
    end
  end

  context 'when there are recommended news feeds' do
    it "does not display 'Nothing too exciting I guess!'" do
      VCR.use_cassette('top_news_service') do
        PullFeedsJob.new.perform
        user.feeds << Feed.first
        signed_in_user user
        expect(page.current_path).to eq root_path
        click_link 'Recommended News'
        expect(page.current_path).to eq recommended_news_path
        expect(page).to_not have_content 'Nothing too exciting I guess!'
      end
    end
  end
end
