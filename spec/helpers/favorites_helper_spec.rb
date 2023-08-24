require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the FavoritesHelper. For example:
#
# describe FavoritesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe FavoritesHelper, type: :helper do
  # TODO: with more time would add spec helpers to easier test helpers that rely on current_user to test has_favorited?
  describe "favorited_by?" do
    context 'when users have favorited post' do
      before do
        Favorite.create!( { post_id: 1, user: User.create(first_name: 'Gojo', last_name: 'Satoru', email: 'f@b.c', password: 'foobar123') })
        Favorite.create!( { post_id: 1, user: User.create(first_name: 'Nanami', last_name: 'Kento', email: 'g@h.b', password: 'foobar123') })
      end

      it 'returns full names separated by a comma' do
        expect(helper.favorited_by(1)).to eq('Gojo Satoru, Nanami Kento')
      end
    end

    context 'when no users have favorited a post' do
      it 'returns an empty string' do
        expect(helper.favorited_by(2)).to eq('')
      end
    end
  end
end
