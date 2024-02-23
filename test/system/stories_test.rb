require "application_system_test_case"

class StoriesTest < ApplicationSystemTestCase
  setup do
    @user = FactoryBot.create(:user)
  end

  test "can like story" do
    VCR.use_cassette("hacker_news_item") do
      sign_in @user
      visit story_path(HACKER_NEWS_ITEM_ID)
      click_on "Like"
      assert_text @user.email
    end
  end
end
