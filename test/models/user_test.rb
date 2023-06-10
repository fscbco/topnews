require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should have many user_stories" do
    user = User.new
    assert_respond_to user, :user_stories
  end

end
