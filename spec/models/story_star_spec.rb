require 'rails_helper'

RSpec.describe StoryStar, type: :model do
  context "creating a new story" do
    let(:attrs) do
      {
        user: User.create!(email: "u@gmail.com", password: "password1"),
        story: Story.create!(external_id: "1", author: "a", title: "b")
      }
    end

    it "should require user_id" do
      expect(StoryStar.new(attrs.except(:user))).to be_invalid
    end

    it "should require story_id" do
      expect(StoryStar.new(attrs.except(:story))).to be_invalid
    end

    it "is valid with an external_id, title and author" do
      expect { StoryStar.create(attrs) }.to change{ StoryStar.count }.by(1)
    end

    it "can not be created twice for the same user/story combo" do
      StoryStar.create!(attrs)

      expect { StoryStar.create(attrs) }.to raise_error { PG::UniqueViolation }
    end
  end
end
