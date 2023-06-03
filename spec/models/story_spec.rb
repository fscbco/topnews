require 'rails_helper'

RSpec.describe Story, type: :model do

  describe 'associations' do
    it { should have_many(:user_stories) }
    it { should have_many(:users).through(:user_stories) }
  end

  describe "validations" do
    it "is valid with a title and url and reference_id" do
      story = FactoryBot.build(:story)
      expect(story).to be_valid
    end

    it "is invalid without a reference_id" do
      story = FactoryBot.build(:story, reference_id: nil)
      expect(story).not_to be_valid
    end

    it "is invalid without a url" do
      story = FactoryBot.build(:story, url: nil)
      expect(story).not_to be_valid
    end

    it "is invalid without a title" do
      story = FactoryBot.build(:story, title: nil)
      expect(story).not_to be_valid
    end
  end
end
