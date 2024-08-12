require 'rails_helper'

RSpec.describe Story, type: :model do
  it { should have_many(:starred_stories) }
  it { should have_many(:users).through(:starred_stories) }
  
  it { should validate_presence_of(:hacker_news_id) }
  it { should validate_uniqueness_of(:hacker_news_id) }

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:story)).to be_valid
    end
  end
end