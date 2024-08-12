require 'rails_helper'

RSpec.describe StarredStory, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:story) }

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:starred_story)).to be_valid
    end
  end
end