require 'rails_helper'

describe User do
  context "creating a new user" do
    let(:attrs) do
      { first_name: :foo, last_name: :bar, email: 'f@b.c', password: 'foobar123' }
    end

    it "should have first, last, email" do
      expect { User.create(attrs) }.to change{ User.count }.by(1)
    end

    it "should require a password" do
      expect(User.new(attrs.except(:password))).to be_invalid
    end
  end

  describe '#familiar_name' do
    let(:user) {User.new(first_name: 'Test', last_name: 'Name')}

    it 'returns the users first name and last initial' do
      expect(user.familiar_name).to eq('Test N.')
    end
  end
end
