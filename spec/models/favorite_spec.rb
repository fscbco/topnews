require 'rails_helper'

RSpec.describe Favorite, type: :model do
  context "creating a new favorite" do
    let(:attrs) do
      { post_id: 1, user: User.create(first_name: :foo, last_name: :bar, email: 'f@b.c', password: 'foobar123') }
    end

    it "should have a post_id and user" do
      expect { Favorite.create(attrs) }.to change{ Favorite.count }.by(1)
    end

    it "should require a post_id" do
      expect(Favorite.new(attrs.except(:post_id))).to be_invalid
    end

    # Association validation is checked on save to the DB instead of on new instance creation, so checked create! instead
    it "should require a user" do
      expect { Favorite.create!(attrs.except(:user)) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
