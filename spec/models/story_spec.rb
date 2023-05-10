require 'rails_helper'

RSpec.describe Story, type: :model do
  describe 'associations' do
    it { should have_many(:flagged_stories) }
    it { should have_many(:users).through(:flagged_stories) }
  end
end
