require 'rails_helper'

RSpec.describe Star, type: :model do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }
  let(:story) { Story.create(hacker_news_id: 1, title: 'Sample Story', url: 'http://example.com') }

  it 'creates a valid star' do
      star = Star.create(user: user, story: story)
      expect(star).to be_valid
  end

  describe 'callbacks' do
    it 'removes the story when the last star is destroyed' do
      star = Star.create(user: user, story: story)
      expect { star.destroy }.to change { Story.count }.by(-1)
    end

    it 'does not remove the story if other stars remain' do
        user1 = User.create(email: 'testuser1@example.com', password: 'password')
        user2 = User.create(email: 'testuser2@example.com', password: 'password')
        story = Story.create(hacker_news_id: 13, title: 'Story to Keep', url: 'http://example.com')
        star1 = Star.create(user: user1, story: story)
        star2 = Star.create(user: user2, story: story)

        # Destroy one star and ensure the story still exists
        star1.destroy
        expect(Story.exists?(story.id)).to be true
    end
  end
end