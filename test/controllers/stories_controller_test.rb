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

  test "should star a story" do
    StoriesController.any_instance.stubs(:fetch_stories).returns([@story])

    assert_difference('@story.user_stories.count') do
      post star_story_url(@story)
    end
    assert_redirected_to root_path
  end

  test "should handle error when fetching top stories" do
    StoriesController.any_instance.stubs(:fetch_stories).raises(StandardError, "Failed to fetch stories")

    get stories_url
    assert_redirected_to root_path
    assert_equal "An error occurred while saving new stories: Failed to fetch stories", flash[:error]
  end

  test "should handle error when retrieving starred stories" do
    Story.expects(:includes).raises(StandardError, "Failed to retrieve starred stories")

    get starred_stories_url
    assert_redirected_to root_path
    assert_equal "An error occurred while retrieving the starred stories: Failed to retrieve starred stories", flash[:error]
  end

  test "should handle error when starring a story" do
    Story.stubs(:find_by).raises(ActiveRecord::RecordNotFound)

    post star_story_url(@story)
    assert_redirected_to root_path
    assert_match(/Story not found/, flash[:error])
  end
end
