require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  let(:user) { create(:user) }
  let(:story) { create(:story) }

  describe 'validations' do
    it 'validates uniqueness of user_id scoped to story_id' do
      original = create(:recommendation)
      duplicate = build(:recommendation, user: original.user, story: original.story)
      expect(duplicate).to_not be_valid
    end
  end

  describe 'creation' do
    it 'is valid with valid attributes' do
      recommendation = described_class.new(user: user, story: story)
      expect(recommendation).to be_valid
    end

    it 'is not valid without a user' do
      recommendation = described_class.new(story: story)
      expect(recommendation).to_not be_valid
    end

    it 'is not valid without a story' do
      recommendation = described_class.new(user: user)
      expect(recommendation).to_not be_valid
    end
  end

  describe 'uniqueness' do
    it 'does not allow duplicate recommendations' do
      create(:recommendation, user: user, story: story)
      duplicate = build(:recommendation, user: user, story: story)
      expect(duplicate).to_not be_valid
    end

    it 'allows the same user to recommend different stories' do
      create(:recommendation, user: user, story: story)
      new_story = create(:story)
      new_recommendation = build(:recommendation, user: user, story: new_story)
      expect(new_recommendation).to be_valid
    end

    it 'allows different users to recommend the same story' do
      create(:recommendation, user: user, story: story)
      new_user = create(:user)
      new_recommendation = build(:recommendation, user: new_user, story: story)
      expect(new_recommendation).to be_valid
    end
  end
end
