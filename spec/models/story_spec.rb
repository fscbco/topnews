require 'rails_helper'

RSpec.describe Story, type: :model do
  let(:user) { User.create(email: 'DonaldGMiller@example.com', password: 'eeMaev2shai') }
  let(:story) { Story.create(title: 'RandomStory', url: 'google.com', story_id: 1, user: user, flagged: false) }

  it 'should have uniqueness of story_id' do
    duplicate_story = Story.new(story_id: story.story_id)
    expect(duplicate_story.valid?).to be_falsey
    expect(duplicate_story.errors[:story_id]).to include("already exists")
  end

  it 'should validate presence of title' do
    story.title = nil
    expect(story.valid?).to be_falsey
    expect(story.errors[:title]).to include("can't be blank")
  end

  it 'should validate presence of url' do
    story.url = nil
    expect(story.valid?).to be_falsey
    expect(story.errors[:url]).to include("can't be blank")
  end

  it 'should belongs to a user' do
    expect(story.user).to eq(user)
  end

  it 'should default to false flag value' do
    expect(story.flagged).to be(false)
  end
end
