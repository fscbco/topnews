require 'rails_helper'

RSpec.describe Story, type: :model do
  it "is valid with valid attributes" do
    story = build(:story)
    expect(story).to be_valid
  end

  it "is not valid without a title" do
    story = build(:story, title: nil)
    expect(story).to_not be_valid
  end

  it "is not valid without a url" do
    story = build(:story, url: nil)
    expect(story).to_not be_valid
  end

  it "is not valid without an hn_id" do
    story = build(:story, hn_id: nil)
    expect(story).to_not be_valid
  end
end