require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @story = stories(:one)
  end

  test "should star a story for a user" do
    assert_not @story.starred?

    @story.star_by(@user)
    assert_predicate @story.reload, :starred?
    assert @story.starring_users.include?(@user)
  end

  test "should raise StoryNotFoundError when story is not found" do
    assert_raises Story::StoryNotFoundError do
      @story.star_by(nil)
    end
  end
end
