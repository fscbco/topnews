require 'rails_helper'


RSpec.describe HackerNews::AddNewStories do
  subject(:service) { described_class}
    
  describe '#call' do
    context 'when service is called' do
      it 'adds new stories' do
        result = service.new([41234588]).call
        expect(result.success?).to  be true        
      end

      it 'fails to add' do
        result = service.new([99999999111]).call
        expect(result.success?).to  be false        
      end
    end

    context 'does not add if story is already save in NewsDetail' do
      it 'does not save' do
        service.new([41229573, 41229555, 41235733, 41235723, 41235721]).call
         
         service.new([41229600, 41229597, 41229595, 41229589, 41229582,
                      41229573, 41229555, 41235733, 41235723, 41235721]).call

         
         expect(NewsDetail.count).to eq(10)
         
      end
    end
  end
end