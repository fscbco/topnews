require 'rails_helper'

RSpec.describe Story, type: :model do
  context "creating a new story" do
    let(:attrs) do
      { external_id: "asdf", title: "Foo Bar", author: "Baz Bot", url: "foobar.net" }
    end

    it "should require external_id" do
      expect(Story.new(attrs.except(:external_id))).to be_invalid
    end

    it "should require title" do
      expect(Story.new(attrs.except(:title))).to be_invalid
    end

    it "should require author" do
      expect(Story.new(attrs.except(:author))).to be_invalid
    end

    it "is valid with an external_id, title and author" do
      expect { Story.create(attrs) }.to change{ Story.count }.by(1)
    end
  end
end
