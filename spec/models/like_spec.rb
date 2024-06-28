# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:story) { create(:story) }
  let(:user) { create(:user) }
  let(:like) { Like.new(story:, user:) }

  describe 'associations' do
    it 'belongs to a story' do
      association = described_class.reflect_on_association(:story)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(like).to be_valid
    end

    it 'is not valid without a story' do
      like.story = nil
      expect(like).not_to be_valid
      expect(like.errors[:story]).to include('must exist')
    end

    it 'is not valid without a user' do
      like.user = nil
      expect(like).not_to be_valid
      expect(like.errors[:user]).to include('must exist')
    end

    it 'is not valid without a unique combination of story and user' do
      Like.create!(story:, user:)
      duplicate_like = Like.new(story:, user:)
      expect(duplicate_like).not_to be_valid
      expect(duplicate_like.errors[:story_id]).to include('has already been taken')
    end
  end
end
