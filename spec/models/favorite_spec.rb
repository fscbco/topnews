require 'rails_helper'

RSpec.describe Favorite do
  context "creating a new Favorite" do
    let(:user) { create(:user) }
    let(:story) { create(:story) }
    let(:attrs) { {user_id: user.id, story_id: story.id} }

    it "should create a favorite assocation." do
      expect { described_class.create!(attrs) }.to change{ described_class.count }.by(1)
    end

    it "should raise error unless required fields are present" do
      expect { described_class.create!(attrs.except(:user_id)) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { described_class.create!(attrs.except(:story_id)) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
