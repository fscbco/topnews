require 'rails_helper'

RSpec.describe Story, type: :model do
  subject { build(:story) }

  describe 'associations' do
    it { should have_many(:flags).dependent(:destroy) }
    it { should have_many(:flagged_by_users).through(:flags).source(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).scoped_to(:url) }
    it { should validate_presence_of(:url) }
  end
end
