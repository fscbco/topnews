require 'test_helper'
require 'mocha/minitest'

class StoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @story = stories(:one)
    @user = users(:one)
    sign_in @user
    @controller = StoriesController.new
  end

  test "should get index" do
    get stories_url
    assert_response :success
  end

  test "should handle error when fetching top stories" do
    StoriesController.any_instance.stubs(:fetch_stories).raises(StandardError, "Failed to fetch stories")

    get stories_url
    assert_redirected_to root_path
    assert_equal "An error occurred while saving new stories: Failed to fetch stories", flash[:error]
  end

end
