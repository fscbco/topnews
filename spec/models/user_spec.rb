require "rails_helper"

RSpec.describe User, :type => :model do

  describe 'associations' do
    it { should have_many(:user_stories) }
    it { should have_many(:stories).through(:user_stories) }
  end

  describe "#name" do
    it "returns user first and last name" do
      u = create(:user, first_name: "Anh", last_name: "Larusso")
      expect(u.name).to eq("Anh Larusso")
    end
  end
end

