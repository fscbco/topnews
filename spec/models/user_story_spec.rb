require 'rails_helper'

RSpec.describe UserStory, type: :model do

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:story) }
  end
end

