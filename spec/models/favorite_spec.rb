require 'rails_helper'

RSpec.describe Favorite, type: :model do
  context "creating a new favorite" do
    let(:attrs) do
      { user_id: 1, story_id: 1}
    end

    it "should have user_id, story_id" do
      expect { Favorite.create(attrs) }.to change{ Favorite.count }.by(1)
    end

  end
end