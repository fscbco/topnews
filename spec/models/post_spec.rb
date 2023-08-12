require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    before { 
      @post = described_class.new(
      title: 'foo', 
      url: 'https://example.com',
      item_id: 1)
      @user = User.create(email: "test@example.com", password: "123123")
    }

    it 'is valid with valid attributes' do
      @post.user = @user
      expect(@post).to be_valid
    end
    
    it 'is invalid if the current_user is not available' do
      expect{(@post.save!)}.to  raise_error(ActiveRecord::RecordInvalid,'Validation failed: User must exist, User can\'t be blank')
    end
  end

  describe "associations" do
    it "belongs to a user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
