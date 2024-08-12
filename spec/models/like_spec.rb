require 'rails_helper'

RSpec.describe Like, type: :model do
  context "creating a new like" do
    let(:attrs) do
      FactoryBot.attributes_for(:like)
    end

    describe "association" do
      it { should belong_to(:user) }
      it { should belong_to(:story) }
    end

  end
end
