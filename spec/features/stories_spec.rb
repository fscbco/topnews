require "rails_helper"

feature "Feature: stories", type: :system do
    include Devise::Test::IntegrationHelpers

    before(:each) do
        FlaggedStory.destroy_all
        User.destroy_all
        @user = create(:user)
    end

    let!(:feed){ create(:feed) }

    scenario 'view latest' do
        sign_in @user

        visit root_path
        feed.stories.each do |story|
            expect(page).to have_selector(:xpath, "//a[@href='#{story['url']}' and text()='#{story['title']}']")
        end
    end

    scenario 'flag / unflag' do
        sign_in @user

        visit root_path

        expect(page).to_not have_content('Flagged stories')

        find_button('FLAG', match: :first).click

        expect(page).to have_content('Your flag was added to the story')
        expect(page).to have_content('Flagged stories')
        expect(page).to have_content("Flagged by: #{@user.full_name}")

        click_link '[Unflag]'

        expect(page).to have_content('Your flag was removed from the story')
        expect(page).to_not have_content('Flagged stories')
    end
end