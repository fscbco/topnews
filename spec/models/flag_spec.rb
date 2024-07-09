require 'rails_helper'

RSpec.describe Flag, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:story) }
  end
end
