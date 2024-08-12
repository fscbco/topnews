require 'rails_helper'

RSpec.describe StoriesHelper, type: :helper do
  describe '#display_star' do
    subject(:star) { helper.display_star(post_id) }

    before do
      @user_faves  = [1, 2, 3]
      @other_faves = [4, 5, 6]
    end

    context 'when post_id is in user_faves' do
      let(:post_id) { 2 }

      it 'returns USER_STAR' do
        expect(star).to eq(StoriesHelper::USER_STAR)
      end
    end

    context 'when post_id is only in other_faves' do
      let(:post_id) { 5 }

      it 'returns OTHER_STAR' do
        expect(star).to eq(link_to(StoriesHelper::OTHER_STAR, favorites_path(post_id:), method: :post))
      end
    end

    context 'when post_id is not favorites by anyone' do
      let(:post_id) { 7 }

      it 'returns NO_STAR' do
        expect(star).to eq(link_to(StoriesHelper::NO_STAR, favorites_path(post_id:), method: :post))
      end
    end
  end
end
