require 'rails_helper'

RSpec.describe Story do
  context "creating a new story" do
    let(:attrs) do
      { 
        external_story_id: 1, 
        title: 'Testing Story Title', 
        url: 'https://reallyrealnews.com/story/1', 
        by: 'the news guy',
        time: DateTime.now
     }
    end

    it "should create a story" do
      expect { described_class.create!(attrs) }.to change{ described_class.count }.by(1)
    end

    it "should raise error unless required fields are present" do
      expect { described_class.create!(attrs.except(:external_story_id)) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { described_class.create!(attrs.except(:title)) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { described_class.create!(attrs.except(:url)) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { described_class.create!(attrs.except(:by)) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { described_class.create!(attrs.except(:time)) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    context 'when a story record is destroyed' do
        let(:user) { create(:user) }
        let(:story) { create(:story)}

        before do
            Favorite.create!(user_id: user.id, story_id: story.id)
        end

        it 'destroy story\'s favorites association' do
            expect(user.favorites.count).to eq(1)
            expect { user.destroy }.to change { Favorite.count }.by(-1)
          end
    end
  end
end
