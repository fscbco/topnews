require 'rails_helper'

describe Star do
  describe 'Validations' do
    describe 'Presence' do
      it { should validate_presence_of(:post) }
      it { should validate_presence_of(:user) }
    end

    describe 'Uniqueness' do
      subject { create(:star) }
      it { should validate_uniqueness_of(:user).scoped_to(:post_id) }
    end
  end

  describe 'Associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end
end
