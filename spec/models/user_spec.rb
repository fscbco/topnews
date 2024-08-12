require 'rails_helper'

describe User do
  it { should have_many(:starred_stories) }
  it { should have_many(:stories).through(:starred_stories) }

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
  end
  
  describe '#star_story' do
    let(:user) { create(:user) }
    let(:story) { create(:story) }

    it 'stars a story' do
      expect { user.star_story(story) }.to change { user.stories.count }.by(1)
    end

    it 'does not star the same story twice' do
      user.star_story(story)
      expect { user.star_story(story) }.not_to change { user.stories.count }
    end
  end

  describe '#unstar_story' do
    let(:user) { create(:user) }
    let(:story) { create(:story) }

    before { user.star_story(story) }

    it 'unstars a story' do
      expect { user.unstar_story(story) }.to change { user.stories.count }.by(-1)
    end
  end
end
