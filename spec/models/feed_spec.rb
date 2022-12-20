require 'rails_helper'

RSpec.describe Feed, type: :model do
  subject(:feed) do
    Feed.create(feed_item_id: 1, source: 'source', source_id: 1, title: 'title', url: 'http://url.com', published: false)
  end

  let(:user) do
    User.create(first_name: 'Gene', last_name: 'Angelo', email: 'gene@b.com', password: 'password')
  end

  describe 'validations' do
    it { should validate_presence_of(:feed_item_id) }
    it { should validate_presence_of(:source) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:source_id) }
    it { should validate_length_of(:source).is_at_most(32) }
    # This raises a warning because bools can't truly be tested, but
    # left here for documentation purposes only.
    # it { should validate_inclusion_of(:published).in_array([true, false]) }
    it { should validate_numericality_of(:feed_item_id).only_integer }
  end

  context 'associations' do
    describe 'users' do
      it { should have_and_belong_to_many(:users) }
    end
  end

  context 'scopes' do
    describe '.recommended_feed_items' do
      context 'when there is at least 1 recommended feed item' do
        before do
          user.feeds << feed
          user.feeds << feed2
        end

        let(:feed2) do
          Feed.create(feed_item_id: 2, source: 'source', source_id: 2, title: 'title', url: 'http://url.com', published: false)
        end

        it 'returns an Array of recommended feed items' do
          expect(Feed.recommended_feed_items.pluck(:id)).to match_array [feed.id, feed2.id]
        end
      end

      context 'when there are no recommended feed items' do
        before do
          feed
        end

        it 'returns an empty Array' do
          expect(Feed.count.positive?).to eq true
          expect(Feed.recommended_feed_items).to eq []
        end
      end
    end

    describe '.for_page' do
      let!(:feeds) do
        (1..100).each do |i|
          Feed.create(feed_item_id: i, source: "#{i} source", source_id: i, title: "#{i} title", url: 'http://url.com', published: false)
        end
      end

      context 'when there are feeds to return' do
        it 'returns the correct feeds' do
          expect(Feed.for_page(:feed_item_id, 10, 10).pluck(:feed_item_id)).to match_array [*(91..100)]
        end
      end

      context 'when the page/items_per_page combination exceeds the number of Feed items' do
        it 'returns an empty Array' do
          expect(Feed.for_page(:feed_item_id, 10, 200).pluck(:feed_item_id)).to eq []
        end
      end
    end
  end

  context 'instance methods' do
    describe '#recommended?' do
      context 'when at least 1 user has recommended this feed' do
        before do
          user.feeds << feed
        end

        it 'returns true' do
          expect(feed.recommended?).to eq true
        end
      end

      context 'when no users have recommended this feed' do
        it 'returns false' do
          expect(feed.recommended?).to eq false
        end
      end
    end

    describe '#recommended_by' do
      context 'when users have recommended the feed' do
        before do
          user.feeds << feed
          User.create(first_name: 'Amy', last_name: 'Angelo', email: 'amy@b.com', password: 'password').feeds << feed
        end

        it 'returns a list of users full names' do
          expect(feed.recommended_by).to match_array ['Amy Angelo', 'Gene Angelo']
        end
      end

      context 'when no users have recommended the feed' do
        it 'returns a empty Array' do
          expect(feed.recommended_by).to eq []
        end
      end
    end
  end
end
