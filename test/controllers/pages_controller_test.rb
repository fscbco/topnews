require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @user = users(:one)
    sign_in @user
  end

  test "should redirect to stories path on home page" do
    get :home
    assert_redirected_to stories_path
  end

  test "should require authentication for home page" do
    sign_out @user
    get :home
    assert_redirected_to new_user_session_path
  end
end
