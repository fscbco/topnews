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

end
