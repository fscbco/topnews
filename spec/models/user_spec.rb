require 'rails_helper'

describe User do
  context "creating a new user" do
    let(:attrs) do
      FactoryBot.attributes_for(:user)
    end

    it "should have first, last, email" do
      expect { User.create(attrs) }.to change{ User.count }.by(1)
    end

    it "should require a password" do
      expect(User.new(attrs.except(:password))).to be_invalid
    end
  end
end
