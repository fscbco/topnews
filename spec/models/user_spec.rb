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

  it "has a full name" do
    user = User.new(first_name: "John", last_name: "Doe")
    expect(user.full_name).to eq("John Doe")
  end
end
