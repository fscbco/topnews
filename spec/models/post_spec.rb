require 'rails_helper'

describe Post do
  describe 'Validations' do
    describe 'Presence' do
      it { should validate_presence_of(:author) }
      it { should validate_presence_of(:hn_created_at) }
      it { should validate_presence_of(:hn_id) }
      it { should validate_presence_of(:post_type) }
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:url) }
    end

    describe 'Uniqueness' do
      subject { build(:post) }

      it { should validate_uniqueness_of(:hn_id).case_insensitive }
    end
  end

  describe 'Associations' do
    it { should have_many(:stars).dependent(:destroy) }
    it { should have_many(:starred_users) }
  end
end
