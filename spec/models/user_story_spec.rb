require 'rails_helper'

RSpec.describe UserStory, type: :model do
  it "is valid with valid attributes" do
    user_story = build(:user_story)
    expect(user_story).to be_valid
  end

  it "is not valid without a user" do
    user_story = build(:user_story, user: nil)
    expect(user_story).to_not be_valid
  end

  it "is not valid without a story" do
    user_story = build(:user_story, story: nil)
    expect(user_story).to_not be_valid
  end
end
