require 'rails_helper'

RSpec.describe Flag, type: :model do
  let(:user) { User.create(email: 'DonaldGMiller@example.com', password: 'eeMaev2shai', first_name: 'Donald',last_name: 'Miller', id: 1) }
  let(:story) { Story.create(title: 'RandomStory', url: 'google.com', story_id: 1, user: user, flagged: true) }

  describe 'validations' do
    subject { Flag.new(user: user, story: story) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:story_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:story) }
  end

  describe 'create flag' do
    it 'should belong to a user and a story' do
      flag = Flag.create(user_id: user.id, story_id: story.id)
      expect(flag.user).to eq(user)
      expect(flag.story).to eq(story)
    end
  end
end
