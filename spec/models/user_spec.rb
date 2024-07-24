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

    context 'when a user record is destroyed' do
      let(:user) { create(:user) }
      let(:story) { create(:story) }

      before do
        Favorite.create!(user_id: user.id, story_id: story.id)
      end

      it 'destroy user\'s favorites association' do
        expect(user.favorites.count).to eq(1)
        expect { user.destroy }.to change { Favorite.count }.by(-1)
      end
    end
  end
end
