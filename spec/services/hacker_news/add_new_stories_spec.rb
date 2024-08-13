require 'rails_helper'

RSpec.describe HackerNews::AddNewStories do
  subject(:service) { described_class }

  describe '#call' do
    context 'when service is called' do
      it 'adds new stories' do
        result = service.new([41_234_588]).call
        expect(result.success?).to be true
      end

      it 'fails to add' do
        result = service.new([99_999_999_111]).call
        expect(result.success?).to be false
      end
    end

    context 'does not add if story is already save in NewsDetail' do
      it 'does not save' do
        service.new([41_229_573, 41_229_555, 41_235_733, 41_235_723, 41_235_721]).call

        service.new([41_229_600, 41_229_597, 41_229_595, 41_229_589, 41_229_582,
                     41_229_573, 41_229_555, 41_235_733, 41_235_723, 41_235_721]).call

        expect(NewsDetail.count).to eq(10)
      end
    end
  end
end
