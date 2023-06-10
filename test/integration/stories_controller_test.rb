require 'test_helper'
require 'mocha/minitest'
class StoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @story = stories(:one)
    sign_in @user
  end

  test "should get index" do
    get stories_url
    assert_response :success
    assert_select "h1", "Welcome to Top News"
  end

  test "should star story" do
    StoriesController.any_instance.stubs(:fetch_stories).returns([@story])

    id_param = @story.id.to_s
    StoriesController.any_instance.stubs(:params).returns({ id: id_param })

    assert_difference('UserStory.count', 1) do
      post star_story_url(@story)
    end
    assert_redirected_to root_path

    assert @story.reload.starred?
    assert @story.starring_users.include?(@user)
  end
end
