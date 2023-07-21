require 'rails_helper'

describe Story do
  context "creating a new story" do
    let(:attrs) do
      { story_id: 1 }
    end

    it "should require a story_id" do
      expect(Story.new()).to be_invalid
    end

    it "should require a story_id be unique" do
      Story.create(attrs)
      expect(Story.new(attrs)).to be_invalid
    end

    it "has many starrables" do
      reflection = Story.reflect_on_association(:starrables)
      expect(reflection.macro).to eq(:has_many)
    end
  
    it "has many users through starrables" do
      reflection = Story.reflect_on_association(:users)
      expect(reflection.macro).to eq(:has_many)
      expect(reflection.through_reflection.name).to eq(:starrables)
    end
  end
end
