require 'rails_helper'

RSpec.describe Story, type: :model do
  context "creating a new story" do
    let(:attrs) do
      FactoryBot.attributes_for(:story)
    end

    it "has 0 stories to start" do
      expect(Story.count).to eq(0)
    end

    it "should now have 1 story" do
      expect { Story.create(attrs) }.to change{ Story.count }.by(1)
    end

    it "should require hackernewsid" do
      expect(Story.new(attrs.except(:hackernewsid))).to be_invalid
    end

    it "should require title" do
      expect(Story.new(attrs.except(:title))).to be_invalid
    end

    it "should require url" do
      expect(Story.new(attrs.except(:url))).to be_invalid
    end

    it "should require hn_created_at" do
      expect(Story.new(attrs.except(:hn_created_at))).to be_invalid
    end

  end
end
