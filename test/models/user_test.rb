require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should have many user_stories" do
    user = User.new
    assert_respond_to user, :user_stories
  end

  test "should have Devise modules" do
    user = User.new
    assert user.respond_to?(:email)
    assert user.respond_to?(:encrypted_password)
    assert user.respond_to?(:reset_password_token)
    assert user.respond_to?(:remember_created_at)
    assert user.respond_to?(:sign_in_count)
    assert user.respond_to?(:current_sign_in_at)
    assert user.respond_to?(:last_sign_in_at)
    assert user.respond_to?(:current_sign_in_ip)
    assert user.respond_to?(:last_sign_in_ip)
  end
end
