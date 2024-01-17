require 'rails_helper'

RSpec.describe Story, type: :model do
  describe 'associations' do
    it { should have_many(:user_stories)}
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
  end
end
